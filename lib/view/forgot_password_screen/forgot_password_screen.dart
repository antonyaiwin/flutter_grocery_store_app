import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/forgot_password_screen_controller/forgot_password_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/image_constants.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../utils/functions/validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ForgotPasswordScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                ImageConstants.forgotPassword,
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 10),
              const Text('Please enter the email address'),
              const SizedBox(height: 10),
              Consumer<ForgotPasswordScreenController>(
                builder: (context, value, child) => _emailFieldWidget(value),
              ),
              const SizedBox(height: 10),
              Consumer<ForgotPasswordScreenController>(
                builder: (BuildContext context,
                        ForgotPasswordScreenController value, Widget? child) =>
                    ElevatedButton(
                  onPressed: value.loading
                      ? null
                      : () {
                          provider.sendPasswordResetEmail(context);
                        },
                  child: Center(
                    child: value.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Reset Password',
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _emailFieldWidget(ForgotPasswordScreenController provider) {
    return TextFormField(
      controller: provider.emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        isDense: true,
        prefixIcon: Icon(Iconsax.sms_outline),
      ),
      validator: emailValidator,
    );
  }
}
