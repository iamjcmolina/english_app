import 'package:flutter/material.dart';

class SentenceItemTile extends StatelessWidget {
  final TextStyle style;
  final String placeholder;
  final String placeholderEs;
  final String? en;
  final String? es;
  final String? hint;
  final Widget? trailing;
  final void Function()? onTap;
  final bool isShown;
  final bool isRequired;

  const SentenceItemTile({
    super.key,
    required this.style,
    required this.placeholder,
    this.placeholderEs = '',
    required this.en,
    required this.es,
    this.hint,
    this.trailing,
    this.onTap,
    this.isShown = true,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShown) {
      return const SizedBox.shrink();
    }
    const smallFont = 12.0;
    const starStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    const italicStyle = TextStyle(fontStyle: FontStyle.italic);
    const smallFontStyle = TextStyle(fontSize: smallFont);
    final isEnEmpty = en == null || en!.isEmpty;
    final isEsEmpty = es == null || es!.isEmpty;
    final isHintEmpty = hint == null || hint!.isEmpty;

    return ListTile(
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
              text: isEnEmpty ? null : '$en ',
              style: TextStyle(color: style.color)),
          TextSpan(
              text: '$placeholder ', style: isEnEmpty ? null : smallFontStyle),
          TextSpan(text: isRequired ? '*' : null, style: starStyle),
          if (!isEsEmpty || placeholderEs.isNotEmpty)
            const TextSpan(text: '\n'),
          TextSpan(
              text: isEsEmpty ? null : '$es ',
              style: TextStyle(color: style.color, fontSize: smallFont)),
          TextSpan(
              text: placeholderEs, style: isEsEmpty ? null : smallFontStyle),
        ],
      )),
      subtitle: isHintEmpty ? null : Text(hint!, style: italicStyle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
