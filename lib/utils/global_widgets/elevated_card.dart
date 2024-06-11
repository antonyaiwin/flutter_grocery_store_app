import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    super.key,
    this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.elevation = 0.0,
    this.borderRadius,
    this.padding /* = const EdgeInsets.all(15) */,
    this.border,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: elevation,
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        height: height,
        padding: padding,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          border: border ??
              Border.all(
                color: ColorConstants.hintColor.withOpacity(0.5),
                width: 0.5,
              ),
        ),
        child: child,
      ),
    );
  }
}
