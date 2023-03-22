import 'package:amazon_app/provider/product_provider.dart';
import 'package:amazon_app/vendor/views/screens/main_vendor_screen.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/attributes_tab_screens.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Genel'),
                ),
                Tab(
                  child: Text('Kargo'),
                ),
                Tab(
                  child: Text('Özellikler'),
                ),
                Tab(
                  child: Text('Resim'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributesTabScreens(),
              ImagesTabScreen()
            ],
          ),
          bottomSheet: ElevatedButton(
            onPressed: () async {
              EasyLoading.show(status: 'Lütfen Bekleyiniz...');
              if (_formKey.currentState!.validate()) {
                final productId = Uuid().v4();
                await _firestore.collection('products').doc(productId).set({
                  'productId': productId,
                  'productName': _productProvider.productData['productName'],
                  'productPrice': _productProvider.productData['productPrice'],
                  'quantity': _productProvider.productData['quantity'],
                  'category': _productProvider.productData['category'],
                  'description': _productProvider.productData['description'],
                  'imageUrlList': _productProvider.productData['imageUrlList'],
                  'scheduleDate': _productProvider.productData['scheduleDate'],
                  'chargeShipping':
                      _productProvider.productData['chargeShipping'],
                  'shippingCharge':
                      _productProvider.productData['shippingCharge'],
                  'brandName': _productProvider.productData['brandName'],
                  'sizeList': _productProvider.productData['sizeList'],
                  'vendorId' : FirebaseAuth.instance.currentUser!.uid,
                }).whenComplete(() {
                  _productProvider.clearData();
                  _formKey.currentState!.reset();
                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainVendorScreen(),
                    ),
                  );
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow.shade900,
            ),
            child: Text('Kaydet'),
          ),
        ),
      ),
    );
  }
}
