import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/login_controller.dart';
import 'package:flutter_grocery_store/controller/screens/forgot_password_screen_controller/forgot_password_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/forgot_password_screen/forgot_password_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../controller/registration_controller.dart';
import '../../core/constants/image_constants.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('rebuild');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(
                    MediaQuery.of(context).size.width / 2, 50),
                bottomRight: Radius.elliptical(
                    MediaQuery.of(context).size.width / 2, 50),
              ),
              child: Image.asset(ImageConstants.loginBanner),
            ),
            Form(
              key: context.read<LoginController>().formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Welcome!',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller:
                          context.read<LoginController>().emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        isDense: true,
                        prefixIcon: Icon(Iconsax.sms_outline),
                      ),
                      validator: context.read<LoginController>().emailValidator,
                    ),
                    const SizedBox(height: 15),
                    Consumer<LoginController>(
                      builder: (BuildContext context, value, Widget? child) =>
                          TextFormField(
                        controller:
                            context.read<LoginController>().passwordController,
                        obscureText: value.obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          isDense: true,
                          prefixIcon: const Icon(Iconsax.lock_1_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.togglePasswordVisibility();
                            },
                            icon: Icon(
                              value.obscurePassword
                                  ? Iconsax.eye_slash_outline
                                  : Iconsax.eye_outline,
                            ),
                          ),
                        ),
                        validator:
                            context.read<LoginController>().passwordValidator,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) =>
                                    ForgotPasswordScreenController(),
                                child: const ForgotPasswordScreen(),
                              ),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Consumer<LoginController>(
                      builder: (BuildContext context, value, Widget? child) =>
                          InkWell(
                        onTap: value.loading
                            ? null
                            : () {
                                value.loginClicked(context);
                              },
                        borderRadius: BorderRadius.circular(50),
                        child: Ink(
                          width: double.infinity,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: value.loading
                                ? ColorConstants.primaryBlack.withOpacity(0.5)
                                : ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: value.loading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator())
                                : Text(
                                    'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: ColorConstants.primaryWhite,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dont\'t have an account?'),
                        const SizedBox(width: 2),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (BuildContext context) =>
                                      RegistrationController(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text('Sign Up'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
