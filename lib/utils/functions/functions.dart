import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

showSnackBar(
    {required BuildContext context,
    required String content,
    SnackBarBehavior? behavior}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    behavior: behavior,
  ));
}

showErrorSnackBar(
    {required BuildContext context,
    required String content,
    SnackBarBehavior? behavior}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      behavior: behavior,
      backgroundColor: ColorConstants.snackBarErrorBackground,
    ),
  );
}

showSuccessSnackBar(
    {required BuildContext context,
    required String content,
    SnackBarBehavior? behavior}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      behavior: behavior,
      backgroundColor: ColorConstants.snackBarSuccessBackground,
    ),
  );
}
