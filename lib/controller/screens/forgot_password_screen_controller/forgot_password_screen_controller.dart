import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/utils/functions/widget_route_functions.dart';
import 'package:flutter_grocery_store/view/splash_screen/splash_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/functions/functions.dart';

class ForgotPasswordScreenController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    log('sending otp');
    if (formKey.currentState!.validate()) {
      log('sending otp if');
      loading = true;
      notifyListeners();

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );
        if (context.mounted) {
          await showSuccessDialog(context);
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        if (context.mounted) {
          showErrorSnackBar(
              context: context, content: 'Error sending password reset email');
        }
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    await showMyDialog(
      context: context,
      content: const _SuccessDialogBody(),
    );
  }
}

class _SuccessDialogBody extends StatelessWidget {
  const _SuccessDialogBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/animations/success_check.json',
          width: 150,
          repeat: false,
        ),
        Text(
          'A password reset link will be sent to the email address you provided.',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Text(
          'Please check your inbox and follow the instructions. If you do not receive the email within a few minutes, check your spam folder.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                (route) => false);
          },
          child: const Center(child: Text('Go back to Login')),
        ),
      ],
    );
  }
}
