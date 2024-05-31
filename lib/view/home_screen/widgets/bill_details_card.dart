import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.read<CartController>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          BillDetailsAmountRow(
            icon: Iconsax.note_1_bold,
            title: 'Subtotal (${cart.totalCartCount} items)',
            subtitle: '₹${cart.totalCartPrice.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 15),
          const BillDetailsAmountRow(
              icon: Iconsax.truck_fast_bold,
              title: 'Delivery charge',
              subtitle: '₹20.00'),
          const SizedBox(height: 20),
          Divider(
            color: Colors.black.withOpacity(0.06),
            thickness: 2,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                '₹${(cart.totalCartPrice + 20).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class BillDetailsAmountRow extends StatelessWidget {
  const BillDetailsAmountRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: ColorConstants.hintColor,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorConstants.hintColor),
        ),
        const Spacer(),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorConstants.primaryBlack,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
