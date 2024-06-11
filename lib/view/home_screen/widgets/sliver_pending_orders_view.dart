import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/firebase/firestore_controller.dart';
import 'active_order_widget.dart';

class SliverPendingOrdersView extends StatelessWidget {
  const SliverPendingOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder(
        stream: context
            .read<FireStoreController>()
            .ordersCollection
            .orderBy('orderCreatedTime', descending: true)
            .where('createdUserId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('orderDeliveredTime', isNull: true)
            .where('orderCancelledTime', isNull: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data?.docs;

          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting ||
              data == null ||
              data.isEmpty) {
            return const SizedBox();
          }

          var order = data.first.data().copyWith(
                collectionDocumentId: data.first.id,
              );
          return ActiveOrderWidget(order: order);
        },
      ),
    );
  }
}
