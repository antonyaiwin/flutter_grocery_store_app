import 'package:flutter/material.dart';

class SliverLabelText extends StatelessWidget {
  const SliverLabelText({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
