import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/firebase/firestore_controller.dart';
import 'recent_search_item.dart';
import 'subtitle_tile.dart';

class RecentSearchWidget extends StatelessWidget {
  const RecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FireStoreController>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.recentSearchList.isEmpty) {
          return const SizedBox();
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SubtitleTile(
                title: 'Recent search',
                suffixString: 'clear',
                onSuffixPressed: () async {
                  try {
                    await value.clearRecentSearch();
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
              ),
            ),
            SizedBox(
              height: 39,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = value.recentSearchList[index].data();
                  return Center(
                    child: RecentSearchItem(item: item),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: value.recentSearchList.length,
              ),
            )
          ],
        );
      },
    );
  }
}

class SearchScreenSubtitleText extends StatelessWidget {
  const SearchScreenSubtitleText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
