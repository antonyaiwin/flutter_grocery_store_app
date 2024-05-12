import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/data/dummy_db.dart';

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
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var e = DummyDb.groceryCategories[index];
            return Material(
              elevation: 5,
              type: MaterialType.canvas,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(5),
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
