import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_grocery_store/utils/functions/image_functions.dart';

class FirebaseAuthController extends ChangeNotifier {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> changeDisplayName(String name) async {
    if (currentUser?.displayName == name) {
      return;
    }
    await currentUser?.updateDisplayName(name);
    notifyListeners();
  }

  Future<void> changeProfilePic(Uint8List? imageData) async {
    if (imageData == null) {
      return;
    }
    imageData = await getCompressedImageData(imageData);
    if (imageData == null) {
      return;
    }
    String uid = currentUser?.uid ?? 'unknown';
    final storageRef = FirebaseStorage.instance.ref();
    final folderRef = storageRef.child('user_files');
    final userRef = folderRef.child(currentUser?.uid ?? 'unknown');
    final imageRef = userRef.child('$uid.jpg');
    await imageRef.putData(imageData);
    await currentUser?.updatePhotoURL(
      await imageRef.getDownloadURL(),
    );
    log(currentUser?.photoURL ?? 'null');
    notifyListeners();
  }
}
