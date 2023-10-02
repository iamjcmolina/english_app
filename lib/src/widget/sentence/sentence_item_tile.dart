import 'package:flutter/material.dart';

class SentenceItemTile extends StatelessWidget {
  final Color color;
  final String label;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final void Function()? onTap;
  final bool show;
  final bool required;

  const SentenceItemTile({
    super.key,
    required this.color,
    required this.label,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.show = true,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) {
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
            style: TextStyle(
              fontSize: emptyValue? 14 : 12,
            ),
          ),
          TextSpan(
            text: required? ' *' : '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            )
          )
        ],
      )),
      subtitle: subtitle == null || subtitle!.isEmpty? null
          : Text(subtitle!, style: const TextStyle(fontStyle: FontStyle.italic)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
