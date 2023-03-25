import 'package:amazon_app/provider/cart_provider.dart';
import 'package:amazon_app/views/buyers/inner_screens/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Cart Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _cartProvider.getCartItem.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItem.values.toList()[index];
          return Card(
            child: SizedBox(
              height: 170,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      cartData.imageUrlList[0],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData.productName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        Text(
                          cartData.price.toStringAsFixed(2) + ' ' + 'TL',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: null,
                          child: Text(
                            cartData.productSize,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 115,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade900,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: cartData.quantity == 1
                                        ? null
                                        : () {
                                            _cartProvider.decrement(cartData);
                                          },
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    cartData.quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: cartData.productQuantity ==
                                            cartData.quantity
                                        ? null
                                        : () {
                                            _cartProvider.increment(cartData);
                                          },
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _cartProvider.removeItem(
                                  cartData.productId,
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.cart_badge_minus,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      /* body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alışveriş Sepetiniz Boş',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 5),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Alışverişe Devam Et',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),*/
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutScreen(),
                    ),
                  );
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color:_cartProvider.totalPrice == 0.00 ? Colors.grey : Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                _cartProvider.totalPrice.toStringAsFixed(2) +
                    ' TL' +
                    ' ' +
                    'Siparişi Tamamla',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
