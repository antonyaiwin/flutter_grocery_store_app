import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/photo_screen/photo_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/custom_page_indicator_controller.dart';
import '../../../model/product_model.dart';
import '../../../utils/global_widgets/custom_page_indicartor.dart';
import '../../../utils/global_widgets/my_network_image.dart';

class CarouselImageView extends StatelessWidget {
  const CarouselImageView({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorConstants.primaryWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: item.imageUrl?.length ?? 0,
            itemBuilder: (context, index, realIndex) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoScreen.network(
                      imageUrlList: item.imageUrl,
                      initialIndex: index,
                    ),
                  )),
              child: MyNetworkImage(
                imageUrl: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? item.imageUrl![index]
                    : '',
              ),
            ),
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                context
                    .read<CustomPageIndicatorController>()
                    .setSelectedIndex(index);
              },
            ),
          ),
          const SizedBox(height: 10),
          Consumer<CustomPageIndicatorController>(
            builder: (BuildContext context, CustomPageIndicatorController value,
                    Widget? child) =>
                CustomPageIndicator(
              count: item.imageUrl?.length ?? 0,
              pageIndex: value.selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}
