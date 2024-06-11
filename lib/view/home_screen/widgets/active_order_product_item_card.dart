import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/product_details_screen_controller.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:flutter_grocery_store/view/product_details_screen/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../model/cart_item_model.dart';
import '../../../utils/global_widgets/my_network_image.dart';

class ActiveOrderProductItemCard extends StatelessWidget {
  const ActiveOrderProductItemCard({
    super.key,
    required this.item,
  });

  final CartItemModel? item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductDetailsScreenController(
                context,
                item?.product ?? ProductModel(),
              ),
              child: const ProductDetailsScreen(),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyNetworkImage(
                height: 40,
                width: 40,
                imageUrl: item?.product.imageUrl?.first ?? ''),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.product.name ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${item?.quantity ?? ''} x ${item?.product.getFormattedQuantity() ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstants.hintColor,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
