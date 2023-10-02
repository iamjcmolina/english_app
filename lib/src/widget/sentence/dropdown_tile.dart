import 'package:flutter/material.dart';

import 'sentence_item_tile.dart';

class DropdownTile extends StatefulWidget {
  final Color color;
  final String title;
  final String? subtitle;
  final String? textValue;
  final bool show;
  final bool required;
  final List<Widget> fields;

  const DropdownTile({
    super.key,
    required this.color,
    required this.title,
    this.subtitle,
    this.textValue,
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
          color: widget.color,
          label: '<${widget.title}>',
          value: widget.textValue,
          trailing: Icon(
              isShowingFields? Icons.arrow_drop_up : Icons.arrow_drop_down
          ),
          onTap: toggleFields,
          show: widget.show,
          required: widget.required,
        ),
        if (widget.show && isShowingFields) ...widget.fields,
      ],
    );
  }

  toggleFields() => setState(() => isShowingFields = !isShowingFields);
}