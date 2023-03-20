import 'package:amazon_app/vendor/views/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(clientId:'1:1013005205615:android:6481f96a5444f8b2940d9a'),
              PhoneProviderConfiguration()
            ],
          );
        }

        // Render your application if authenticated
        return LandingScreen();
      },
    );
  }
}
