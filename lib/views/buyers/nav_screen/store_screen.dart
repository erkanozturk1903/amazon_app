import 'package:amazon_app/views/buyers/product_detail/store_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final storeData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreDetailScreen(
                        storeData: storeData,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    storeData['businessName'],
                  ),
                  subtitle: Text(
                    storeData['countryValue'],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      storeData['storeImage'],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
