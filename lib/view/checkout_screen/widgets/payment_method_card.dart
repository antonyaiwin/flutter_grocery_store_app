import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/constants/color_constants.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.child,
    required this.name,
    required this.isSelected,
    this.onTap,
  });

  final Widget child;
  final String name;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.primaryWhite,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: ColorConstants.primaryColor,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.black26.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: child,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(name),
            ),
            if (isSelected)
              const Icon(
                Iconsax.tick_circle_bold,
                color: ColorConstants.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
