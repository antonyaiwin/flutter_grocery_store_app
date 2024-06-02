import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorConstants.hintColor,
          ),
    );
  }
}
