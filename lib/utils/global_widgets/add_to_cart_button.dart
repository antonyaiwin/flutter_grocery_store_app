import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:provider/provider.dart';

const int _durationInMilliseconds = 450;

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    this.onTap,
    this.onAddTap,
    this.onRemoveTap,
    this.width = 100,
    this.height = 40,
    this.label,
    this.dense = false,
    required this.item,
  });
  final ProductModel item;
  final double height;
  final double width;
  final String? label;
  final bool dense;
  final void Function()? onTap;
  final void Function()? onAddTap;
  final void Function()? onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (BuildContext context, value, Widget? child) {
        var count = value.getItemCount(item.id ?? 0);
        return InkWell(
          onTap: count == 0
              ? onTap ??
                  () {
                    value.addItemToCart(item);
                  }
              : null,
          borderRadius: BorderRadius.circular(10),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(50),
            child: Material(
              child: AnimatedContainer(
                height: height,
                width: dense && count == 0 ? height : width,
                duration: const Duration(milliseconds: _durationInMilliseconds),
                decoration: BoxDecoration(
                  color: count == 0 && !dense
                      ? Theme.of(context).primaryColor
                      : null,
                  border: count == 0 && !dense
                      ? null
                      : Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: count == 0 && !dense
                    ? addToCartChild(context)
                    : addRemoveButtons(
                        context,
                        count: count,
                        onAddTap: () {
                          value.addItemToCart(item);
                        },
                        onRemoveTap: () {
                          value.removeItemFromCart(item);
                        },
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addRemoveButtons(
    BuildContext context, {
    required int count,
    void Function()? onAddTap,
    void Function()? onRemoveTap,
  }) {
    return Row(
      mainAxisSize: count != 0 ? MainAxisSize.max : MainAxisSize.min,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: _durationInMilliseconds),
          scale: count == 0 ? 0 : 1,
          child: AnimatedContainer(
            width: count == 0 ? 0 : height - 2,
            height: count == 0 ? 0 : height - 2,
            duration: const Duration(milliseconds: _durationInMilliseconds),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: ColoredAddButton(
                onTap: this.onRemoveTap ?? onRemoveTap,
                icon: Icons.remove,
                size: count == 0 ? 0 : height - 4,
              ),
            ),
          ),
        ),
        Expanded(
          child: AnimatedScale(
            scale: count == 0 ? 0 : 1,
            duration: const Duration(milliseconds: _durationInMilliseconds),
            child: Text(
              textAlign: TextAlign.center,
              count.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1),
          child: ColoredAddButton(
            onTap: this.onAddTap ?? onAddTap,
            icon: Icons.add,
            size: height - 4,
          ),
        ),
      ],
    );
  }

  Widget addToCartChild(BuildContext context) {
    return Center(
      child: Text(
        label ?? 'Add to cart',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

class ColoredAddButton extends StatelessWidget {
  const ColoredAddButton({
    super.key,
    required this.onTap,
    this.icon,
    required this.size,
  });

  final void Function()? onTap;
  final IconData? icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: _durationInMilliseconds),
            scale: size == 0 ? 0 : 1,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
