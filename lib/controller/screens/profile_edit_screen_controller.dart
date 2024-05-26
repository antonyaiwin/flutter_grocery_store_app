import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firebase_auth_controller.dart';
import 'package:flutter_grocery_store/utils/functions/functions.dart';
import 'package:flutter_grocery_store/view/crop_image_screen/crop_image_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditScreenController extends ChangeNotifier {
  BuildContext context;
  TextEditingController nameController = TextEditingController();
  XFile? xFile;
  Uint8List? image;

  bool loading = false;
  ProfileEditScreenController(this.context) {
    nameController.text =
        context.read<FirebaseAuthController>().currentUser?.displayName ?? '';
  }

  Future<void> pickImage(ImageSource source) async {
    xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) {
      return;
    }
    image = await xFile!.readAsBytes();
    if (context.mounted && image != null) {
      image = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropImageScreen(
            image: image!,
            showAspectRatios: false,
            withCircleUi: true,
          ),
        ),
      );
    }

    notifyListeners();
  }

  Future<void> saveUserData() async {
    loading = true;
    notifyListeners();
    try {
      await context.read<FirebaseAuthController>().changeProfilePic(image);
    } on FirebaseException catch (e) {
      log(e.message ?? '');
      if (context.mounted) {
        showErrorSnackBar(
            context: context,
            content: 'Something went wrong while updating profile picture!');
      }
    }
    if (context.mounted) {
      try {
        await context
            .read<FirebaseAuthController>()
            .changeDisplayName(nameController.text);
      } on FirebaseException catch (e) {
        log(e.message ?? '');
        if (context.mounted) {
          showErrorSnackBar(
              context: context,
              content: 'Something went wrong while updating profile name!');
        }
      }
    }
    loading = false;
    notifyListeners();
  }
}
