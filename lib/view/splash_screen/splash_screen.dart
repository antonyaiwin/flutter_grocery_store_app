import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/home_screen_controller.dart';
import 'package:flutter_grocery_store/controller/login_controller.dart';
import 'package:flutter_grocery_store/view/home_screen/home_screen.dart';
import 'package:flutter_grocery_store/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        User? user = FirebaseAuth.instance.currentUser;
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => user == null
                ? ChangeNotifierProvider(
                    create: (BuildContext context) => LoginController(),
                    child: const LoginScreen(),
                  )
                : ChangeNotifierProvider(
                    create: (BuildContext context) => HomeScreenController(),
                    child: const HomeScreen()),
          ),
        );
      },
    );
    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
