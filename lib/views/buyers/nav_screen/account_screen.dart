import 'package:amazon_app/views/buyers/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.yellow.shade900,
              title: Text(
                'Profil Ekranı',
                style: TextStyle(letterSpacing: 2),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.shield_moon),
                )
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      data['profileImage'],
                    ),
                    backgroundColor: Colors.yellow.shade900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['fullName'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['email'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                  ),
                  title: Text('Ayarlar'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                  ),
                  title: Text('Telefon Numarası'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.credit_card,
                  ),
                  title: Text('Kart Bilgileri'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                  ),
                  title: Text('Siparişlerim'),
                ),
                ListTile(
                  onTap: () async {
                    await _auth.signOut().whenComplete(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    });
                  },
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text('Çıkış Yap'),
                )
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
