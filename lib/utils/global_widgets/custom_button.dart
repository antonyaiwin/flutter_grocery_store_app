import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.color = ColorConstants.primaryColor,
    this.disabledColor = const Color.fromARGB(255, 248, 193, 110),
    this.onTap,
    this.expanded = true,
    this.padding,
    this.margin,
    this.overlayColor,
  })  : outlined = false,
        borderColor = null;

  // Outlined button constructor
  const CustomButton.outlined({
    super.key,
    required this.child,
    this.onTap,
    this.expanded = true,
    this.padding,
    this.margin,
    this.borderColor,
    this.overlayColor,
  })  : color = Colors.transparent,
        disabledColor = Colors.transparent,
        outlined = true;

  // Text button constructor
  const CustomButton.text({
    super.key,
    required this.child,
    this.onTap,
    this.expanded = true,
    this.padding,
    this.margin,
    this.overlayColor,
  })  : color = Colors.transparent,
        disabledColor = Colors.transparent,
        outlined = false,
        borderColor = null;

  final Widget child;
  final Color color;
  final Color disabledColor;
  final Color? borderColor;
  final bool expanded;
  final bool outlined;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final MaterialStateProperty<Color?>? overlayColor;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        overlayColor: overlayColor,
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: expanded ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
              color: onTap == null ? disabledColor : color,
              borderRadius: BorderRadius.circular(10),
              border: outlined
                  ? Border.all(
                      color: borderColor ??
                          ColorConstants.black3c.withOpacity(
                            0.18,
                          ),
                    )
                  : null),
          child: Center(
            child: IconTheme(
              data: IconThemeData(
                color: outlined
                    ? ColorConstants.black26
                    : ColorConstants.primaryWhite,
                size: 16,
              ),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 17,
                      color: outlined
                          ? ColorConstants.black26
                          : ColorConstants.primaryWhite,
                      fontWeight: FontWeight.w600,
                    ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
