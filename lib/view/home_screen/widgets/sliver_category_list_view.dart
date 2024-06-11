import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/utils/global_widgets/category_card.dart';
import 'package:provider/provider.dart';

class SliverCategoryListView extends StatelessWidget {
  const SliverCategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: Consumer<FireStoreController>(
          builder: (BuildContext context, value, Widget? child) =>
              GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var e = value.categoryList[index];
              return CategoryCard(item: e);
            },
            itemCount: value.categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 0,
              childAspectRatio: 13 / 9,
            ),
          ),
        ),
      ),
    );
  }
}
