import 'package:amazon_app/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyy');

    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ürün Adı Giriniz';
                  }else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Ürünün Adını Giriniz',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ürün Fiyatı Giriniz';
                  }else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                    productPrice: double.parse(value),
                  );
                },
                decoration: InputDecoration(
                  labelText: 'Ürün Fiyatı Giriniz',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ürünün Miktarını Giriniz';
                  }else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                    quantity: int.parse(value),
                  );
                },
                decoration: InputDecoration(
                  labelText: 'Ürünün Miktarını Giriniz',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                hint: Text('Kategori Seçiniz'),
                items: _categoryList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _productProvider.getFormData(category: value);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Ürün Açıklaması Giriniz';
                  }else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(
                    description: value,
                  );
                },
                maxLines: 4,
                maxLength: 800,
                decoration: InputDecoration(
                    labelText: 'Ürün Açıklaması Giriniz',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(5000),
                      ).then((value) {
                        setState(() {
                          _productProvider.getFormData(scheduleDate: value);
                        });
                      });
                    },
                    child: Text(
                      'Takvim',
                    ),
                  ),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Text(
                      formatedDate(
                        _productProvider.productData['scheduleDate'],
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
