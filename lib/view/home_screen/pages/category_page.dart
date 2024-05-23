// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_widgets/category_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          title: Text('Categories'),
        ),
        Consumer<FireStoreController>(
          builder: (BuildContext context, value, Widget? child) =>
              SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                .copyWith(bottom: 250),
            sliver: SliverGrid.builder(
              itemBuilder: (context, index) {
                var e = value.categoryList[index];
                return CategoryCard(
                  item: e,
                );
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: value.categoryList.length,
            ),
          ),
        ),
      ],
    );
  }
}
