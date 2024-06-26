import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/constants/color_constants.dart';

Future<T?> showMyModalBottomSheet<T>({
  required BuildContext context,
  double? height,
  EdgeInsetsGeometry? contentPadding,
  required ScrollableWidgetBuilder builder,
  double initialChildSize = /* 0.5 */ 0.66,
  double minChildSize = 0.25,
  double maxChildSize = /* 1.0 */ 0.75,
  bool expand = true,
  bool snap = /* false */ true,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet(
    context: context,
    elevation: 0,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomSheet: DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            expand: expand,
            snap: snap,
            builder: (context, scrollController) => Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -60,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: CupertinoColors.black.withOpacity(0.7),
                    radius: 23,
                    child: const Icon(
                      MingCute.close_fill,
                      color: ColorConstants.primaryWhite,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  child: Ink(
                    height: height,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        color:
                            Theme.of(context).bottomSheetTheme.backgroundColor),
                    padding: contentPadding,
                    child: builder(context, scrollController),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<T?> showMyDialog<T>({
  required BuildContext context,
  Widget? content,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstants.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: content,
    ),
  );
}

Future<dynamic> showMyBasicDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function(BuildContext context)? onYesPressed,
  required void Function(BuildContext context)? onNoPressed,
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog.adaptive(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstants.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onYesPressed == null
              ? null
              : () {
                  onYesPressed(context);
                },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: onNoPressed == null
              ? null
              : () {
                  onNoPressed(context);
                },
          child: const Text('No'),
        ),
      ],
    ),
  );
}
