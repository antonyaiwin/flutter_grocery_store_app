// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/core/data/dummy_db.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';

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
              return ElevatedCard(
                elevation: 5,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                          'https://static.vecteezy.com/system/resources/thumbnails/023/290/773/small/fresh-red-apple-isolated-on-transparent-background-generative-ai-png.png'),
                    ),
                    Text(
                      e.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '250g',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '₹${e.price?.toStringAsFixed(1) ?? ''}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SliverCategoryListView extends StatelessWidget {
  const SliverCategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var e = DummyDb.groceryCategories[index];
            return Material(
              elevation: 5,
              type: MaterialType.canvas,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(5),
                height: 100,
                width: 100,
                child: Column(children: [
                  Expanded(
                      child: Image.network(
                    e.imageUrl ?? '',
                    fit: BoxFit.cover,
                  )),
                  Text(
                    e.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ]),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: DummyDb.groceryCategories.length,
        ),
      ),
    );
  }
}
