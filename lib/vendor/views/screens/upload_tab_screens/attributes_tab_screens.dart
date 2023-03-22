import 'package:amazon_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributesTabScreens extends StatefulWidget {
  AttributesTabScreens({Key? key}) : super(key: key);

  @override
  State<AttributesTabScreens> createState() => _AttributesTabScreensState();
}

class _AttributesTabScreensState extends State<AttributesTabScreens> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool _entered = false;
  final TextEditingController _sizeController = TextEditingController();

  List<String> _sizeList = [];

  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(validator: (value){
            if(value!.isEmpty){
              return 'Marka Giriniz';
            }else {
              return null;
            }
          },
            onChanged: (value) {
              _productProvider.getFormData(
                brandName: value,
              );
            },
            decoration: InputDecoration(labelText: 'Marka'),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: Container(
                width: 100,
                child: TextFormField(
                  controller: _sizeController,
                  onChanged: (value) {
                    setState(() {
                      _entered = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Beden',
                  ),
                ),
              )),
              _entered == true
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                        });
                        print(_sizeList);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade900,
                      ),
                      child: Text(
                        'Ekle',
                      ),
                    )
                  : Text(
                      '',
                    ),
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _sizeList.remove(index);
                            _productProvider.getFormData(sizeList: _sizeList);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _sizeList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(sizeList: _sizeList);
                setState(() {
                  _isSave = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900,
              ),
              child: Text(
                _isSave ? 'Kaydedildi' : 'Kaydet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
