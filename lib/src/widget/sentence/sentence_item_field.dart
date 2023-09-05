import 'package:flutter/material.dart';

class SentenceItemField<T extends Object> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> options;
  final String Function(T) displayStringForOption;
  final bool enable;
  final void Function(T) onSelected;
  final void Function()? onCleaned;
  final void Function(String)? onChanged;

  const SentenceItemField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.enable = true,
    required this.onSelected,
    required this.onCleaned,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Autocomplete<T>(
          initialValue: value != null? TextEditingValue(text: nullableToString(value)) : null,
          displayStringForOption: displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return options;
            }
            return options.where((T option) {
              return nullableToString(option).contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: onSelected,
          fieldViewBuilder: (
              BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted
              ) {
            return TextFormField(
              keyboardType: TextInputType.none,
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                label: Text(label),
                suffixIcon: IconButton(
                  onPressed: () {
                    fieldTextEditingController.clear();
                    if (onCleaned != null) onCleaned!();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              validator: (value) => optionFound(value)? null : 'Choose a valid $label',
              autovalidateMode: AutovalidateMode.always,
              onChanged: onChanged,
            );
          }
      ),
    );
  }

  String nullableToString(T? value) => (value == null)? '' : displayStringForOption(value);

  optionFound(value) => options.any((option) => nullableToString(option) == value);
}
