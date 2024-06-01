import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/global_widgets/shimmer_placeholder.dart';

class LocationDetailsShimmer extends StatelessWidget {
  const LocationDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.shimmerBaseColor,
      highlightColor: ColorConstants.shimmerHilightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fetching location details...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ShimmerPlaceHolder(
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceHolder(
                        height: 20,
                      ),
                      SizedBox(height: 5),
                      ShimmerPlaceHolder(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ShimmerPlaceHolder(
              height: 40,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
