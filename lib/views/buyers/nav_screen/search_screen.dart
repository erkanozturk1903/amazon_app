import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searhedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow.shade900,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searhedValue = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Ürün Arama',
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),
      ),
      body: _searhedValue == ''
          ? Center(
              child: Text(
                'Ürün Arama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                final _searhedData = snapshot.data!.docs.where((element) {
                  return element['productName'].toLowerCase().contains(
                        _searhedValue.toLowerCase(),
                      );
                });

                return Column(
                  children: _searhedData.map((search) {
                    return Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(search['imageUrlList'][0]),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                search['productName'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                search['productPrice'].toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
