import 'package:flutter/material.dart';

import 'package:flutter_grocery_store/core/constants/color_constants.dart';

class MyStep extends StatelessWidget {
  const MyStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isLast,
    required this.isCompleted,
  });

  // final OrderDetailsScreenController provider;
  final String title;
  final String? subtitle;
  final bool isLast;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    Color color = isCompleted
        ? ColorConstants.primaryColor
        : ColorConstants.hintColor.withOpacity(0.25);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 7),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(isCompleted ? 0.25 : 0.1),
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            if (!isLast)
              SizedBox(
                height: 30,
                child: VerticalDivider(
                  indent: 5,
                  color: color,
                ),
              ),
          ],
        ),
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isCompleted ? null : ColorConstants.hintColor,
                ),
            children: [
              if (subtitle != null)
                TextSpan(
                  text: '\n$subtitle',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorConstants.hintColor,
                      ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
