import 'package:amazon_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  bool? _chargeShipping = false;



  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            'Kargo Ücreti',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: _chargeShipping,
          onChanged: (value) {
            setState(() {
              _chargeShipping = value;
              _productProvider.getFormData(
                chargeShipping: _chargeShipping,
              );
            });
          },
        ),
        if (_chargeShipping == true)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return 'Kargo Ücreti';
                }else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                  shippingCharge: int.parse(value),
                );
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kargo Ücreti',
              ),
            ),
          )
      ],
    );
  }
}
