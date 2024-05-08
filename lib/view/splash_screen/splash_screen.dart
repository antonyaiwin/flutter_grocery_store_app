import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/login_controller.dart';
import 'package:flutter_grocery_store/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => LoginController(),
            child: const LoginScreen(),
          ),
        ),
      ),
    );
    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
