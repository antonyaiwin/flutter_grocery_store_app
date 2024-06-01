import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

class ShimmerPlaceHolder extends StatelessWidget {
  const ShimmerPlaceHolder({
    super.key,
    this.decoration,
    this.width,
    this.height,
    this.constraints,
    this.child,
  });
  final Decoration? decoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
            color: ColorConstants.primaryWhite,
            borderRadius: BorderRadius.circular(10),
          ),
      constraints: constraints,
      child: child,
    );
  }
}
