import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/image_constants.dart';
import 'package:flutter_grocery_store/utils/functions/validators.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../controller/screens/change_password_screen_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ChangePasswordScreenController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SvgPicture.asset(
                ImageConstants.privacyImage,
                height: 300,
                width: 300,
              ),
              Consumer<ChangePasswordScreenController>(
                builder: (BuildContext context,
                        ChangePasswordScreenController value, Widget? child) =>
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
              Consumer<ChangePasswordScreenController>(
                builder: (BuildContext context,
                        ChangePasswordScreenController value, Widget? child) =>
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
              Consumer<ChangePasswordScreenController>(
                builder: (BuildContext context,
                        ChangePasswordScreenController value, Widget? child) =>
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
              const SizedBox(height: 10),
              Consumer<ChangePasswordScreenController>(
                builder: (BuildContext context,
                        ChangePasswordScreenController value, Widget? child) =>
                    ElevatedButton(
                  onPressed: value.loading
                      ? null
                      : () {
                          provider.updatePassword(context);
                        },
                  child: Center(
                    child: value.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Update Password'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
