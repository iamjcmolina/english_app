import 'package:flutter/material.dart';

import 'sentence_item_tile.dart';

class DropdownTile extends StatefulWidget {
  final TextStyle style;
  final String title;
  final String? subtitle;
  final String? textValue;
  final String? textValueEs;
  final bool show;
  final bool required;
  final List<Widget> fields;

  const DropdownTile({
    super.key,
    required this.style,
    required this.title,
    this.subtitle,
    this.textValue,
    this.textValueEs,
    this.show = true,
    this.required = false,
    required this.fields,
  });

  @override
  State<DropdownTile> createState() => _DropdownTileState();
}

class _DropdownTileState extends State<DropdownTile> {
  bool isShowingFields = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SentenceItemTile(
          style: widget.style,
          placeholder: '<${widget.title}>',
          en: widget.textValue,
          es: widget.textValueEs,
          trailing: Icon(
              isShowingFields ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleFields,
          isShown: widget.show,
          isRequired: widget.required,
        ),
        if (widget.show && isShowingFields) ...widget.fields,
      ],
    );
  }

  toggleFields() => setState(() => isShowingFields = !isShowingFields);
}
