import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/product_details_screen_controller.dart';
import 'package:flutter_grocery_store/utils/global_widgets/product_card.dart';
import 'package:provider/provider.dart';

import 'package:flutter_grocery_store/controller/custom_page_indicator_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/utils/global_widgets/offer_tag.dart';

import '../../controller/cart_controller.dart';
import '../../core/constants/color_constants.dart';
import '../../model/product_model.dart';
import '../../utils/global_widgets/add_to_cart_button.dart';
import '../../utils/global_widgets/my_network_image.dart';
import 'widgets/carousel_image_view.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.item});
  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    var offer = item.getOffer();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Consumer<FireStoreController>(
        builder: (context, myType, child) {
          var item =
              myType.getProductById(this.item.collectionDocumentId ?? '');
          if (item == null) {
            return const Center(
              child: Text('Failed to fetch details!'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ChangeNotifierProvider(
                          create: (BuildContext context) =>
                              CustomPageIndicatorController(),
                          child: CarouselImageView(item: item),
                        ),

                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Quantity
                              Text(
                                item.getFormattedQuantity(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (offer == null)
                                    Text(
                                      'MRP: ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  // Selling Price
                                  Text(
                                    '₹${item.getFormattedSellingPrice()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  if (offer == null)
                                    Text(
                                      ' (Incl. of all taxes)',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  const SizedBox(width: 10),

                                  // Offer
                                  if (offer != null) OfferTag(text: offer),
                                ],
                              ),

                              if (offer != null)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'MRP: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: ColorConstants.hintColor,
                                          ),
                                    ),
                                    // MRP price
                                    Text(
                                      '₹${item.getFormattedMRP()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: ColorConstants.hintColor,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor:
                                                ColorConstants.primaryRed,
                                          ),
                                    ),
                                    Text(
                                      ' (Incl. of all taxes)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: ColorConstants.hintColor,
                                          ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),

                              // Rating
                              if (item.rating != null &&
                                  item.ratingCount != null)
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      double rating = item.rating ?? 0;
                                      return Icon(
                                        Icons.star,
                                        size: 15,
                                        color:
                                            rating.round() ~/ (index + 1) == 0
                                                ? Colors.grey
                                                : Colors.amber,
                                      );
                                    }),

                                    const SizedBox(width: 10),
                                    // Text(
                                    //   item.rating.count.toString(),
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodyMedium
                                    //       ?.copyWith(
                                    //           color: Colors.amber,
                                    //           fontWeight: FontWeight.bold),
                                    // ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${item.ratingCount ?? 0} Ratings',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  'No ratings yet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              const SizedBox(height: 20),
                              Text(
                                'Category',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  MyNetworkImage(
                                      height: 50,
                                      width: 50,
                                      imageUrl: context
                                              .read<FireStoreController>()
                                              .getCategoryById(
                                                  item.categoryId ?? '')
                                              ?.imageUrl ??
                                          ''),
                                  const SizedBox(width: 10),
                                  Text(
                                    context
                                            .read<FireStoreController>()
                                            .getCategoryById(
                                                item.categoryId ?? '')
                                            ?.name ??
                                        'No category',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorConstants.hintColor,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.description ?? '',
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                        // Similar Products
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Similar Products',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          child: Consumer<ProductDetailsScreenController>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return value.similarItems.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          AspectRatio(
                                              aspectRatio: 17 / 28,
                                              child: ProductCard(
                                                  item: value
                                                      .similarItems[index])),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 10),
                                      itemCount: value.similarItems.length);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 215, 215),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.getFormattedSellingPrice(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Consumer<CartController>(
                      builder: (context, value, child) {
                        return AddToCartButton(
                          count: value.getItemCount(item.id!),
                          onTap: () {
                            value.addItemToCart(item);
                          },
                          onAddTap: () {
                            value.addItemToCart(item);
                          },
                          onRemoveTap: () {
                            value.removeItemFromCart(item);
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
