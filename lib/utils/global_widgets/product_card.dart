import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/product_details_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/favorite_button.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:provider/provider.dart';

import '../../controller/cart_controller.dart';
import '../../model/product_model.dart';
import '../../view/product_details_screen/product_details_screen.dart';
import 'add_to_cart_button.dart';
import 'elevated_card.dart';
import 'offer_tag.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      // elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) =>
                  ProductDetailsScreenController(context, item),
              child: ProductDetailsScreen(item: item),
            ),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MyNetworkImage(
                        imageUrl:
                            item.imageUrl != null && item.imageUrl!.isNotEmpty
                                ? item.imageUrl![0]
                                : '',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.name ?? '',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.25,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    children: [
                      // Selling Price
                      Text(
                        '₹${item.getFormattedSellingPrice()}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primaryGreen,
                                ),
                      ),
                      const SizedBox(width: 3),

                      // MRP
                      if (item.getOffer() != null)
                        Text(
                          '₹${item.getFormattedMRP()}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorConstants.hintColor,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: ColorConstants.primaryRed,
                                  ),
                        ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.end,
                          item.getFormattedQuantity(),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Consumer<CartController>(
                    builder: (BuildContext context, value, Widget? child) =>
                        AddToCartButton(
                      count: value.getItemCount(item.id ?? 0),
                      label: 'ADD',
                      height: 30,
                      width: double.infinity,
                      onTap: () {
                        value.addItemToCart(item);
                      },
                      onAddTap: () {
                        value.addItemToCart(item);
                      },
                      onRemoveTap: () {
                        value.removeItemFromCart(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (item.getOffer() != null)
              Positioned(
                left: 10,
                child: OfferTag(text: item.getOffer()!),
              ),
            Positioned(
              right: 10,
              top: 10,
              child: FavoriteButton(item: item),
            ),
          ],
        ),
      ),
    );
  }
}
