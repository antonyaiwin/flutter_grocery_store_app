import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/registration_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_constants.dart';
import '../../utils/functions/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: context.read<RegistrationController>().formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style:
                            const TextStyle(color: ColorConstants.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller:
                      context.read<RegistrationController>().nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user_outline),
                    labelText: 'Name',
                    isDense: true,
                  ),
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller:
                      context.read<RegistrationController>().emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.sms_outline),
                    labelText: 'Email',
                    isDense: true,
                  ),
                  validator: emailValidator,
                ),
                const SizedBox(height: 15),
                Consumer<RegistrationController>(
                  builder: (BuildContext context, value, Widget? child) =>
                      TextFormField(
                    controller: value.passwordController,
                    obscureText: value.obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.lock_1_outline),
                      labelText: 'Password',
                      isDense: true,
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
                    validator: passwordValidator,
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<RegistrationController>(
                  builder: (BuildContext context, value, Widget? child) =>
                      InkWell(
                    onTap: value.loading
                        ? null
                        : () {
                            value.signupClicked(context);
                          },
                    borderRadius: BorderRadius.circular(50),
                    child: Ink(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
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
                                'Sign Up',
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
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: 'By signing up, you are agreeing to our ',
                    children: [
                      TextSpan(
                        text: 'Terms of Service',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style:
                            const TextStyle(color: ColorConstants.primaryBlue),
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style:
                            const TextStyle(color: ColorConstants.primaryBlue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
