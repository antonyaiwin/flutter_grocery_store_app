import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/utils/functions/functions.dart';

class ChangePasswordScreenController extends ChangeNotifier {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  Future<void> updatePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      var user = FirebaseAuth.instance.currentUser;
      try {
        await user!.reauthenticateWithCredential(EmailAuthProvider.credential(
            email: user.email!, password: currentPasswordController.text));

        await user.updatePassword(newPasswordController.text);
        if (context.mounted) {
          showSuccessSnackBar(
              context: context, content: 'Password updated successfully');
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        String msg = 'Something went wrong';
        if (e.code == 'invalid-credential') {
          msg = 'The current password is incorrect!';
        } else if (e.code == 'weak-password') {
          msg = 'The new password provided is too weak.';
        }
        if (context.mounted) {
          showErrorSnackBar(
            context: context,
            content: msg,
          );
        }
      } on Exception {
        if (context.mounted) {
          showErrorSnackBar(context: context, content: 'Something went wrong!');
        }
      }
      loading = false;
      notifyListeners();
    }
  }

  void toggleCurrentPasswordVisibility() {
    obscureCurrentPassword = !obscureCurrentPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }
}
