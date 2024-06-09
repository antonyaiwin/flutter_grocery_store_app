import 'package:flutter/material.dart';

import 'recent_search_widget.dart';

class SubtitleTile extends StatelessWidget {
  const SubtitleTile(
      {super.key,
      required this.title,
      this.suffixString,
      this.onSuffixPressed});
  final String title;
  final String? suffixString;
  final void Function()? onSuffixPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchScreenSubtitleText(
            text: title,
          ),
        ),
        if (suffixString != null)
          TextButton(
            onPressed: onSuffixPressed,
            child: Text(suffixString ?? ''),
          ),
      ],
    );
  }
}
