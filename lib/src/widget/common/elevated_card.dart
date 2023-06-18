import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  final List<Widget> children;

  const ElevatedCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
