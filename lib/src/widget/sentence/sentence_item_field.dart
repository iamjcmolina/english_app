import 'package:flutter/material.dart';

class SentenceItemField<T extends Object> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> options;
  final String Function(T) displayStringForOption;
  final bool enable;
  final void Function(T) onSelected;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;

  const SentenceItemField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.enable = true,
    required this.onSelected,
    required this.onChanged,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingController = this.textEditingController ?? TextEditingController();
    textEditingController.text = value != null? nullableToString(value) : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: RawAutocomplete<T>(
        displayStringForOption: displayStringForOption,
        focusNode: FocusNode(),
        textEditingController: textEditingController,
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
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted
            ) {
          return TextFormField(
            keyboardType: TextInputType.none,
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              label: Text(label),
              suffixIcon: IconButton(
                onPressed: () {
                  textEditingController.clear();
                  if (onChanged != null) onChanged!('');
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            validator: (value) => optionFound(value)? null : 'Choose a valid $label',
            autovalidateMode: AutovalidateMode.always,
            onChanged: onChanged,
          );
        },
        optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<T> onSelected,
            Iterable<T> options,
            ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final T option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () => onSelected(option),
                      child: ListTile(
                        title: Text(displayStringForOption(option)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String nullableToString(T? value) => (value == null)? '' : displayStringForOption(value);

  optionFound(value) => options.any((option) => nullableToString(option) == value);
}
