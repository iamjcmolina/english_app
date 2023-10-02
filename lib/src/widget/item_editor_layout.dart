import 'package:flutter/material.dart';

class ItemEditorLayout extends StatelessWidget {
  final List<Widget> header;
  final List<Widget> body;

  const ItemEditorLayout({super.key, required this.header, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...header,
        Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: body,
                  ),
                ),
                const SizedBox(height: 175),
              ],
            )
        ),
      ],
    );
  }
}
