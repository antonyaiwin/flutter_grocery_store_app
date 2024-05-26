import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/functions/functions.dart';
import 'package:flutter_grocery_store/utils/functions/widget_route_functions.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/screens/profile_edit_screen_controller.dart';
import '../../utils/global_widgets/custom_button.dart';
import '../../utils/global_widgets/elevated_card.dart';
import '../../utils/global_widgets/profile_circle_avatar.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showImagePickBottomSheet(context);
              },
              child: Stack(
                children: [
                  Consumer<ProfileEditScreenController>(
                    builder: (context, value, child) {
                      if (value.xFile != null) {
                        return CircleAvatar(
                          backgroundImage: FileImage(File(value.xFile!.path)),
                          radius: 70,
                        );
                      }
                      return const ProfileCircleAvatar(
                        radius: 70,
                      );
                    },
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedCard(
                      padding: EdgeInsets.zero,
                      elevation: 1,
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller:
                  context.read<ProfileEditScreenController>().nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            Consumer<ProfileEditScreenController>(
              builder: (BuildContext context, value, Widget? child) =>
                  ElevatedButton(
                onPressed: value.loading
                    ? null
                    : () async {
                        await context
                            .read<ProfileEditScreenController>()
                            .saveUserData();
                        if (!context.mounted) {
                          return;
                        }
                        Navigator.pop(context);
                        showSuccessSnackBar(
                            context: context,
                            content: 'Profile updated successfully.');
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (value.loading)
                      const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator())
                    else
                      const Text('Save'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickBottomSheet(BuildContext context) {
    showMyModalBottomSheet(
      context: context,
      height: 210,
      initialChildSize: 0.25,
      maxChildSize: 0.25,
      builder: (ctx, scrollController) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton.outlined(
              onTap: () async {
                await context
                    .read<ProfileEditScreenController>()
                    .pickImage(ImageSource.camera);
                if (context.mounted) {
                  Navigator.pop(ctx);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.camera_outline,
                    color: Colors.blue.shade700,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Capture with camera',
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.black3c.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomButton.outlined(
              onTap: () async {
                await context
                    .read<ProfileEditScreenController>()
                    .pickImage(ImageSource.gallery);
                if (context.mounted) {
                  Navigator.pop(ctx);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.gallery_outline,
                    color: ColorConstants.primaryColor,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Pick from gallery',
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.black3c.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
