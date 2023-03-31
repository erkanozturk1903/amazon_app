// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatelessWidget {
  WithdrawalScreen({Key? key}) : super(key: key);
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAccountNameController =
      TextEditingController();
  final TextEditingController _bankAccountNumberController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String amount;
  late String name;
  late String mobile;
  late String bankName;
  late String bankAccountName;
  late String bankAccountNumber;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Para Çek',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Tutar Bilgisini Giriniz';
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Tutar Giriniz'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen İsim Bilgisini Giriniz';
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'İsim'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Cep Telefonu Bilgisini Giriniz';
                    }
                  },
                  onChanged: (value) {
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Cep Telefonu'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Banka Adını Giriniz';
                    }
                  },
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Banka Adı'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Banka Hesap Adını Giriniz';
                    }
                  },
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Banka Hesap Adı'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Banka IBAN Numarasını Giriniz';
                    }
                  },
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'IBAN Numarası'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //TODO: Date cloud firestore
                      await _firestore
                          .collection('withdrawal')
                          .doc(Uuid().v4())
                          .set({
                        'Amount': amount,
                        'Name': name,
                        'Mobile': mobile,
                        'BankName': bankName,
                        'BankAccountName': bankAccountName,
                        'BankAccountNumber': bankAccountNumber,
                      });
                      print('cooll');
                    } else {
                      print('false');
                    }
                  },
                  child: Text(
                    'Parayı Çek',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
