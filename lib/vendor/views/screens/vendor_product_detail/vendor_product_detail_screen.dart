import 'package:amazon_app/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorProductDetailScreen extends StatefulWidget {
  const VendorProductDetailScreen({
    Key? key,
    required this.productData,
  }) : super(key: key);
  final dynamic productData;

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _productDescriptionController.text = widget.productData['description'];
      _categoryNameController.text = widget.productData['category'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toString();
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          widget.productData['productName'],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Ürün Adı',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _brandNameController,
                decoration: InputDecoration(
                  labelText: 'Marka Adı',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  productQuantity = int.parse(value);
                },
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Adet',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: 'Fiyat',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 800,
                maxLines: 3,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Açıklama',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: ()async{
            if(productPrice != null && productQuantity != null){
              await _firestore.collection('products')
                  .doc(widget.productData['productId'])
                  .update({
                'productName' : _productNameController.text,
                'brandName' : _brandNameController.text,
                'quantity' : productQuantity,
                'productPrice' : productPrice,
                'description' : _productDescriptionController.text,
                'category' : _categoryNameController.text,
              });
            }else{
              showSnack(context, 'Ürünün fiyat ve Adedi Güncellendi');
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.shade900),
            child: Center(
              child: Text(
                'Ürün Güncelle',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 18,
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
