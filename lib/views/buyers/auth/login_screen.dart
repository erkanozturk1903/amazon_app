import 'package:amazon_app/controllers/auth_controller.dart';
import 'package:amazon_app/utils/show_snackbar.dart';
import 'package:amazon_app/views/buyers/auth/register_screen.dart';
import 'package:amazon_app/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false;

  loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_fromKey.currentState!.validate()) {
      String res = await _authController.loginUser(
        email,
        password,
      );

      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Lütfen bilgilerinizi kontrol ediniz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Müşteri Hesabına Giriş Yapın',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen E-mail adresini giriniz';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail Adresinizi Girin',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen Şifre giriniz';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Şifrenizi Girin',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  loginUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:_isLoading ? CircularProgressIndicator(color: Colors.white,): Text(
                      'Giriş Yap',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bir Hesabın Yok Mu?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text('Üye Ol'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
