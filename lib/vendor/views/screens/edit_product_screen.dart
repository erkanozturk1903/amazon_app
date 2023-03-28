import 'package:amazon_app/vendor/views/screens/edit_products_tab/published_tab.dart';
import 'package:amazon_app/vendor/views/screens/edit_products_tab/unpublished_tab.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Ürün Yönetimi',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Yayınlanan '),
              ),
              Tab(
                child: Text('Yayınlanmamış'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnpublishedTab()
          ],
        ),
      ),
    );
  }
}
