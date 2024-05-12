// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/data/dummy_db.dart';

import '../../../utils/global_widgets/product_card.dart';
import '../widgets/sliver_category_list_view.dart';
import '../widgets/sliver_label_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: FirebaseAuth.instance.currentUser?.photoURL ==
                      null
                  ? null
                  : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
              child: FirebaseAuth.instance.currentUser?.displayName == null
                  ? null
                  : Center(
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName![0],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi,',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${FirebaseAuth.instance.currentUser?.displayName}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for \'Grocery\'',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        SliverLabelText(
          label: 'Shop by category',
        ),
        SliverCategoryListView(),
        SliverLabelText(
          label: 'Saved',
        ),
        SliverCategoryListView(),
        SliverLabelText(
          label: 'Everything',
        ),
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 9 / 13,
            ),
            itemBuilder: (context, index) {
              var e = DummyDb.groceryItems[index];
              return ProductCard(item: e);
            },
            itemCount: DummyDb.groceryItems.length,
          ),
        ),
      ],
    );
  }
}
