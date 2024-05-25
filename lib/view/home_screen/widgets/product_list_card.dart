import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/controller/screens/product_details_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';
import '../../../model/product_model.dart';
import '../../../utils/global_widgets/favorite_button.dart';
import '../../product_details_screen/product_details_screen.dart';
import '../../../utils/global_widgets/add_to_cart_button.dart';
import '../../../utils/global_widgets/elevated_card.dart';
import '../../../utils/global_widgets/offer_tag.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({
    super.key,
    required this.item,
    this.onDelete,
  });

  final ProductModel item;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      height: 130,
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
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: MyNetworkImage(
                      imageUrl:
                          item.imageUrl != null && item.imageUrl!.isNotEmpty
                              ? item.imageUrl![0]
                              : '',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _getNameSection(context),
                        ),
                        Row(
                          children: [
                            // Selling Price
                            Text(
                              '₹${item.getFormattedSellingPrice()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primaryGreen,
                                  ),
                            ),
                            const SizedBox(width: 3),

                            // MRP
                            if (item.getOffer() != null)
                              Text(
                                '₹${item.getFormattedMRP()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorConstants.hintColor,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor:
                                          ColorConstants.primaryRed,
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (item.getOffer() != null)
                              OfferTag(text: item.getOffer()!),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                            Expanded(
                              child: Text(
                                '${item.rating ?? 'No ratings yet'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorConstants.hintColor,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Consumer<CartController>(
                                builder: (BuildContext context, value,
                                        Widget? child) =>
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: FavoriteButton(
                item: item,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNameSection(BuildContext context) {
    if (onDelete != null) {
      return Row(
        children: [
          Expanded(child: _getNameWidget(context)),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Iconsax.trash_outline),
          ),
        ],
      );
    }
    return _getNameWidget(context);
  }

  Widget _getNameWidget(BuildContext context) {
    return Text(
      item.name ?? '',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            height: 1.25,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
