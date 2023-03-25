import 'package:amazon_app/models/cart_attributes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttributes> _cartItems = {};

  Map<String, CartAttributes> get getCartItem {
    return _cartItems;
  }

  double get totalPrice{
    var total = 0.00;
    _cartItems.forEach((key, value) {
     total += value.price * value.quantity;
    });

    return total;

  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrlList,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    String productSize,
    Timestamp scheduleDate,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (exitingCart) => CartAttributes(
          productName: exitingCart.productName,
          productId: exitingCart.productId,
          imageUrlList: exitingCart.imageUrlList,
          quantity: exitingCart.quantity + 1,
          productQuantity: exitingCart.productQuantity,
          price: exitingCart.price,
          vendorId: exitingCart.vendorId,
          productSize: exitingCart.productSize,
          scheduleDate: exitingCart.scheduleDate,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttributes(
          productName: productName,
          productId: productId,
          imageUrlList: imageUrlList,
          quantity: quantity,
          productQuantity: productQuantity,
          price: price,
          vendorId: vendorId,
          productSize: productSize,
          scheduleDate: scheduleDate,
        ),
      );
      notifyListeners();
    }
  }

  void increment(CartAttributes cartAttributes) {
    cartAttributes.increase();
    notifyListeners();
  }

  void decrement(CartAttributes cartAttributes) {
    cartAttributes.decrease();
    notifyListeners();
  }

  removeItem(productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  removeAllItem(){
    _cartItems.clear();
    notifyListeners();
  }

}
