import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    super.key,
    this.child,
    this.width,
    this.height,
    this.elevation = 0.0,
    this.borderRadius,
    this.padding /* = const EdgeInsets.all(15) */,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        height: height,
        padding: padding,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          border: Border.all(
            color: ColorConstants.hintColor.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: child,
      ),
    );
  }
}
