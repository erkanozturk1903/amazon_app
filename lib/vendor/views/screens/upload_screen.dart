import 'package:amazon_app/vendor/views/screens/upload_tab_screens/attributes_tab_screens.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:amazon_app/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
      ),
    );
  }
}
