import 'package:flutter/material.dart';

class PhraseBuilderCard extends StatelessWidget {
  PhraseBuilderCard({
    super.key,
    required this.children,
    this.title,
    this.options,
    this.menu,
  });
  final List<Widget> children;
  String? title;
  List<Widget>? options;
  List<Widget>? menu;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black26),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if(title!=null) Text(title!),
                    if(title!=null) const SizedBox(width: 8,),
                    ...?options
                  ],
                ),
                if(menu !=null) Row( children: menu!,),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
