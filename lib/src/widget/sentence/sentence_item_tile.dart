import 'package:flutter/material.dart';

class SentenceItemTile extends StatelessWidget {
  final Color color;
  final String label;
  final String? subtitle;
  final String? value;
  final String? valueEs;
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
    this.valueEs,
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
    final isEmptyValue = value == null || value!.isEmpty;
    return ListTile(
      title: Text.rich(TextSpan(
        children: [
          if (!isEmptyValue)
            TextSpan(
              text: value,
              style: TextStyle(color: color),
            ),
          TextSpan(
            text: isEmptyValue ? label : ' $label',
            style: TextStyle(
              fontSize: isEmptyValue ? 14 : 12,
            ),
          ),
          TextSpan(
              text: required ? ' *' : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              )),
          TextSpan(
            text: valueEs == null ? '' : '\n$valueEs',
            style: TextStyle(
              color: isEmptyValue ? null : color,
              fontSize: isEmptyValue ? 14 : 12,
            ),
          ),
        ],
      )),
      subtitle: subtitle == null || subtitle!.isEmpty
          ? null
          : Text(subtitle!,
              style: const TextStyle(fontStyle: FontStyle.italic)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
