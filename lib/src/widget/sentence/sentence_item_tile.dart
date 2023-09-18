import 'package:flutter/material.dart';

class SentenceItemTile extends StatelessWidget {
  final Color color;
  final String label;
  final String? value;
  final bool hide;
  final Widget? trailing;
  final String? subtitle;
  final void Function()? onTap;

  const SentenceItemTile({
    super.key,
    required this.color,
    required this.label,
    this.value,
    this.hide = false,
    this.trailing,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (hide) {
      return const SizedBox.shrink();
    }
    bool emptyValue = value == null || value!.isEmpty;
    return ListTile(
      title: Text.rich(TextSpan(
        children: [
          if (!emptyValue) TextSpan(
            text: value,
            style: TextStyle(color: color),
          ),
          TextSpan(
            text: emptyValue? label : ' $label',
            style: TextStyle(fontSize: emptyValue? 14 : 12),
          ),
        ],
      )),
      subtitle: subtitle == null || subtitle!.isEmpty? null
          : Text(subtitle!, style: const TextStyle(fontStyle: FontStyle.italic)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
