import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget? leading;
  final Widget item;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;

  const ListItem({super.key, this.leading, required this.item, this.trailing, this.contentPadding});
  
  @override
  Widget build(BuildContext context) {
    final resolvedContentPadding = contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0);

    return Padding(
      padding: resolvedContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
              children: [
                if (leading !=null) leading!,
                item
              ],
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
