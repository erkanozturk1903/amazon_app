import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesTabScreen extends StatefulWidget {
  ImagesTabScreen({Key? key}) : super(key: key);

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen> {
  final ImagePicker picker = ImagePicker();

  List<File> _image = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      print('resim yüklenmedi');
    } else {
      setState(() {
        _image.add(
          File(pickedFile.path),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: _image.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 3 / 3),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          chooseImage();
                        },
                        icon: Icon(Icons.add),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: FileImage(
                          _image[index - 1],
                        ),
                      )),
                    );
            },
          ),
          SizedBox(height: 30,),
          TextButton(
            onPressed: (){},
            child: Text('Yükle'),
          )
        ],
      ),
    );
  }
}
