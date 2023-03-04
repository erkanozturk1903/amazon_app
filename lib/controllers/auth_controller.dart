import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signUpUsers(
      String email, String password, String fullName, String phoneNumber) async {
    String res = 'Bazı hatalar oluştu';
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        // TODO: create User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
        );

        res = 'success';

      }else {
        res = 'Lütfen tüm alanları doldurunuz';
      }
    } catch (e) {

    }
    return res;
  }
}
