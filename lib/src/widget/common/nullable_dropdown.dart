import 'package:flutter/material.dart';

class NullableDropdown<T extends Object> extends StatelessWidget {
  const NullableDropdown({
    super.key,
    required this.labelNull,
    required this.value,
    required this.setValue,
    required this.options,
    required this.optionToString,
    this.onSetValue
  });
  final String labelNull;
  final T? value;
  final Function(T?) setValue;
  final List<T> options;
  final Function(T?)? onSetValue;
  final String Function(T) optionToString;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T?>(
      value: value,
      onChanged: (T? value) {
        setValue(value);
        if (onSetValue != null ) {
          onSetValue!(value);
        }
      },
      items: [
        DropdownMenuItem<T?>(
          value: null,
          child: Text(labelNull,
            style: const TextStyle(color: Colors.black26,fontSize: 12),
          ),
        ),
        ...options.map<DropdownMenuItem<T?>>((T? item) {
          return DropdownMenuItem<T?>(
            value: item,
            child: Text(optionToString(item!)),
          );
        }).toList()
      ],
    );
  }
}
