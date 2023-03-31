import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VendorOrderScreen extends StatelessWidget {
   VendorOrderScreen({Key? key}) : super(key: key);

  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Tüm Siparişlerim',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
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

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Slidable(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: document['accepted'] == true
                            ? Icon(Icons.delivery_dining)
                            : Icon(
                                Icons.access_time,
                              ),
                      ),
                      title: document['accepted'] == true
                          ? Text(
                              'Onaylandı',
                              style: TextStyle(
                                color: Colors.yellow.shade900,
                              ),
                            )
                          : Text(
                              'Onaylanmadı',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                      trailing: Text(
                        'Fiyat ' +
                            ' ' +
                            document['productPrice'].toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        formatedDate(
                          document['orderDate'].toDate(),
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Sipariş Detayı',
                        style: TextStyle(
                          color: Colors.yellow.shade900,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        'Sipariş Detayını Görüntüle',
                      ),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(document['productImage'][0]),
                          ),
                          title: Text(
                            document['productName'],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Adet',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(document['quantity'].toString())
                                ],
                              ),
                              document['accepted'] == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Teslimat Tarihini Planla'),
                                        Text(
                                          formatedDate(
                                            document['scheduleDate'].toDate(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(''),
                              ListTile(
                                title: Text(
                                  'Alıcı Detay',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['fullName'],
                                    ),
                                    Text(
                                      document['email'],
                                    ),
                                    Text(
                                      document['address'],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(
                              document['orderId'],
                            )
                            .update({
                          'accepted': false,
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Reddet',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(
                              document['orderId'],
                            )
                            .update({
                          'accepted': true,
                        });
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Onayla',
                    ),
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
