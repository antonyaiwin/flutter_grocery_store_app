import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/controller/screens/category_page_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

import '../widgets/category_list_card.dart';
import '../widgets/home_screen_back_button.dart';
import '../widgets/product_list_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<CategoryPageController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('All Categories'),
      // ),
      body: Row(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 90,
                child: Consumer2<FireStoreController, CategoryPageController>(
                  builder: (BuildContext context, firestore, categoryController,
                          Widget? child) =>
                      ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          height: kToolbarHeight +
                              MediaQuery.of(context).padding.top,
                          decoration: BoxDecoration(
                            color: ColorConstants.categorySliderBackground,
                            borderRadius: categoryController.categoryList[index]
                                        .collectionDocumentId ==
                                    categoryController.selectedCategoryId
                                ? const BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  )
                                : null,
                          ),
                        );
                      }
                      var e = firestore.categoryList[index - 1];
                      return CategoryListCard(
                        category: e,
                        isSelected: provider.selectedCategoryId ==
                            e.collectionDocumentId,
                        isPrevious: provider.selectedCategoryId ==
                                    e.collectionDocumentId ||
                                index >= categoryController.categoryList.length
                            ? false
                            : categoryController
                                    .categoryList[index].collectionDocumentId ==
                                categoryController.selectedCategoryId,
                        isNext: provider.selectedCategoryId ==
                                    e.collectionDocumentId ||
                                index < 2
                            ? false
                            : categoryController.categoryList[index - 2]
                                    .collectionDocumentId ==
                                categoryController.selectedCategoryId,
                        onTap: () {
                          categoryController
                              .changeCategory(e.collectionDocumentId ?? '');
                        },
                      );
                    },
                    itemCount: firestore.categoryList.length + 1,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
                width: 90,
                decoration: const BoxDecoration(
                  color: ColorConstants.categorySliderBackground,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: const HomeScreenBackButton(),
              ),
            ],
          ),
          // const VerticalDivider(
          //   width: 1,
          // ),
          Expanded(
            child: SafeArea(
              child: Consumer2<FireStoreController, CategoryPageController>(
                builder:
                    (BuildContext context, fireStore, value, Widget? child) {
                  return Column(
                    children: [
                      AppBar(
                        title: Text(value.getCurrentCategoryName()),
                        surfaceTintColor: Colors.transparent,
                      ),
                      if (value.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (value.filteredProducts.isEmpty)
                        const Center(
                          child: Text('No products found!'),
                        )
                      else
                        Expanded(
                          child: ListView.separated(
                            controller: value.productsScrollController,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) => ProductListCard(
                                item: value.filteredProducts[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: value.filteredProducts.length,
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
