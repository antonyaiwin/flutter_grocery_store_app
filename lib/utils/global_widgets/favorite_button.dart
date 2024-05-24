import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/firebase/firestore_controller.dart';
import '../../model/product_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireStoreController>(
      builder:
          (BuildContext context, FireStoreController value, Widget? child) {
        bool favorite =
            value.favouritesList.contains(item.collectionDocumentId);
        return InkWell(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          onTap: () {
            if (favorite) {
              value.deleteFavorite(item);
            } else {
              value.addFavorite(item);
            }
          },
          child: Icon(favorite ? Icons.favorite : Icons.favorite_border),
        );
      },
    );
  }
}
