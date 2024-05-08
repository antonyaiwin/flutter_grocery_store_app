import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loading = false;

  String? emailValidator(String? value) {
    if (EmailValidator.validate(value ?? '')) {
      return null;
    } else {
      return 'Enter valid email address!';
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.length < 8) {
      return 'Enter a valid password with minimum 8 characters!';
    } else if (value.length > 15) {
      return 'Enter a valid password with maximum 15 characters!';
    } else {
      return null;
    }
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> loginClicked(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        UserCredential user =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
        if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Entered Email or Password is incorrect!')));
          log('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          log('Wrong password provided for that user.');
        }
      }
      loading = false;
      notifyListeners();
    }
  }
}
