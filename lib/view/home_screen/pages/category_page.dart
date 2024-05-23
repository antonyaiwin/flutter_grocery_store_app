import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/controller/screens/category_page_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/category_model.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_widgets/product_list_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<CategoryPageController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 90,
            child: Consumer2<FireStoreController, CategoryPageController>(
              builder: (BuildContext context, firestore, categoryController,
                      Widget? child) =>
                  ListView.separated(
                itemBuilder: (context, index) {
                  var e = firestore.categoryList[index];
                  return CategoryListCard(
                    category: e,
                    isSelected:
                        provider.selectedCategoryId == e.collectionDocumentId,
                    onTap: () {
                      categoryController
                          .changeCategory(e.collectionDocumentId ?? '');
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  endIndent: 10,
                  color: ColorConstants.hintColor.withOpacity(0.2),
                ),
                itemCount: firestore.categoryList.length,
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
          ),
          Expanded(
            child: Consumer<CategoryPageController>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.filteredProducts.isEmpty) {
                  return const Center(
                    child: Text('No products found!'),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) =>
                      ProductListCard(item: value.filteredProducts[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: value.filteredProducts.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  final CategoryModel category;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                color: ColorConstants.primaryColor.withOpacity(0.125),
                border: const Border(
                  left: BorderSide(
                    color: ColorConstants.primaryColor,
                    width: 4,
                  ),
                ),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10),
                ),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyNetworkImage(
              imageUrl: category.imageUrl ?? '',
              height: null,
            ),
            Text(
              category.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
