import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function()? onPressed;
  final bool highlight;
  final bool disableLeftPadding;

  const ItemButton({
    super.key,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.highlight = false,
    this.disableLeftPadding = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.fromLTRB(disableLeftPadding? 0 : 10, 10, 10, 10)
        ),
      ),
      child: Column(
        children: [
          Text(title,
              style: highlight? const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ) : null,
          ),
          if(subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 10, color: Colors.grey),),
        ],
      ),
    );
  }
}
