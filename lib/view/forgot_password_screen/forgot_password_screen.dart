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
                builder: (context, value, child) {
                  if (value.otpConfirmed) {
                    return _newPasswordWidget(value);
                  } else if (value.otpSend) {
                    return Column(
                      children: [
                        Text(
                          'One Time Password has been send to ${value.emailController.text}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 10),
                        const Pinput(),
                      ],
                    );
                  } else {
                    return _emailFieldWidget(value);
                  }
                },
              ),
              const SizedBox(height: 10),
              Consumer<ForgotPasswordScreenController>(
                builder: (BuildContext context,
                        ForgotPasswordScreenController value, Widget? child) =>
                    ElevatedButton(
                  onPressed: value.loading
                      ? null
                      : () {
                          if (value.otpConfirmed) {
                            provider.updatePassword(context);
                          } else if (value.otpSend) {
                            provider.confirmOtp(context);
                          } else {
                            provider.sendOtp(context);
                          }
                        },
                  child: Center(
                    child: value.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : Text(value.otpSend ? 'Confirm' : 'Send OTP'),
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

  Column _newPasswordWidget(ForgotPasswordScreenController provider) {
    return Column(
      children: [
        Consumer<ForgotPasswordScreenController>(
          builder: (BuildContext context, ForgotPasswordScreenController value,
                  Widget? child) =>
              TextFormField(
            controller: provider.currentPasswordController,
            decoration: InputDecoration(
              labelText: 'Current Password',
              prefixIcon: const Icon(Iconsax.lock_1_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  value.toggleCurrentPasswordVisibility();
                },
                icon: Icon(
                  value.obscureCurrentPassword
                      ? Iconsax.eye_slash_outline
                      : Iconsax.eye_outline,
                ),
              ),
            ),
            obscureText: value.obscureCurrentPassword,
            validator: passwordValidator,
          ),
        ),
        const SizedBox(height: 10),
        Consumer<ForgotPasswordScreenController>(
          builder: (BuildContext context, ForgotPasswordScreenController value,
                  Widget? child) =>
              TextFormField(
            controller: provider.newPasswordController,
            decoration: InputDecoration(
              labelText: 'New Password',
              prefixIcon: const Icon(Iconsax.lock_1_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  value.toggleNewPasswordVisibility();
                },
                icon: Icon(
                  value.obscureNewPassword
                      ? Iconsax.eye_slash_outline
                      : Iconsax.eye_outline,
                ),
              ),
            ),
            obscureText: value.obscureNewPassword,
            validator: passwordValidator,
          ),
        ),
        const SizedBox(height: 10),
        Consumer<ForgotPasswordScreenController>(
          builder: (BuildContext context, ForgotPasswordScreenController value,
                  Widget? child) =>
              TextFormField(
            controller: provider.confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              prefixIcon: const Icon(Iconsax.lock_1_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  value.toggleConfirmPasswordVisibility();
                },
                icon: Icon(
                  value.obscureConfirmPassword
                      ? Iconsax.eye_slash_outline
                      : Iconsax.eye_outline,
                ),
              ),
            ),
            obscureText: value.obscureConfirmPassword,
            validator: (value) {
              return passwordConfirmValidator(
                provider.newPasswordController.text,
                provider.confirmPasswordController.text,
              );
            },
          ),
        ),
      ],
    );
  }
}
