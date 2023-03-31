import 'package:amazon_app/vendor/views/screens/vendor_product_detail/vendor_product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PublishedTab extends StatelessWidget {
  PublishedTab({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorProductsStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('approved', isEqualTo: true)
        .snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade900,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Yayınlanmış Ürün Bulunamadı',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }

          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final vendorProductData = snapshot.data!.docs[index];
                return Slidable(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorProductDetailScreen(
                            productData: vendorProductData,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              vendorProductData['imageUrlList'][0],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendorProductData['productName'],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                vendorProductData['productPrice']
                                        .toStringAsFixed(2) +
                                    ' TL',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow.shade900,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          await _firestore
                              .collection('products')
                              .doc(vendorProductData['productId'])
                              .update({
                            'approved': false,
                          });
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.approval_rounded,
                        label: 'Yayınlanmamış',
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          _firestore
                              .collection('products')
                              .doc(vendorProductData['productId'])
                              .delete();
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
