// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/controller/screens/category_view_screen_controller.dart';
import 'package:flutter_grocery_store/controller/screens/search_screen_controller.dart';
import 'package:flutter_grocery_store/view/category_view_screen/category_view_screen.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:flutter_grocery_store/view/search_screen/widgets/subtitle_tile.dart';
import 'package:provider/provider.dart';

import 'recent_search_widget.dart';

class SearchPlaceholder extends StatelessWidget {
  const SearchPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RecentSearchWidget(),
          ProductCategoryList(),
        ],
      ),
    );
  }
}

class ProductCategoryList extends StatelessWidget {
  const ProductCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenController>(
      builder:
          (BuildContext context, SearchScreenController value, Widget? child) =>
              SizedBox(
        height: 500,
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var item = value.productCategoryList[index];
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleTile(
                    title: value.getCategory(item.first.categoryId)?.name ?? '',
                    suffixString: 'see all',
                    onSuffixPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => CategoryViewScreenController(
                              context,
                              category:
                                  value.getCategory(item.first.categoryId)!,
                            ),
                            child: CategoryViewScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => ProductListCard(item: item[i]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: item.length,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: value.productCategoryList.length,
        ),
      ),
    );
  }
}
