import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/login_controller.dart';
import 'package:flutter_grocery_store/utils/functions/functions.dart';
import 'package:flutter_grocery_store/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class RegistrationController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loading = false;

  String? nameValidator(String? value) {
    if ((value?.length ?? 0) > 5) {
      return null;
    } else {
      return 'Enter valid name!';
    }
  }

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

  Future<void> signupClicked(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await user.user?.updateDisplayName(nameController.text);
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Registration successful.'),
              content: const Text('Please login to continue.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (BuildContext context) => LoginController(),
                          child: const LoginScreen(),
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
        if (!context.mounted) {
          return;
        }
        String snackBarMessage = 'Something went wrong!';
        switch (e.code) {
          case 'weak-password':
            snackBarMessage = 'The password provided is too weak.';
            log(snackBarMessage);
            break;
          case 'email-already-in-use':
            snackBarMessage = 'The account already exists for that email';
            log(snackBarMessage);
            break;
          case 'invalid-email':
            snackBarMessage = 'Entered Email is Invalid!';
            log(snackBarMessage);
            break;
        }

        showErrorSnackBar(
          context: context,
          content: snackBarMessage,
        );
      }
    }
    loading = false;
    notifyListeners();
  }
}
