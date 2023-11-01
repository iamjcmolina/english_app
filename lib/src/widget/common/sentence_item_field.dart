import 'package:flutter/material.dart';

class SentenceItemField<T extends Object> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> options;
  final String Function(T) displayStringForOption;
  final Iterable<String Function(T)> filterValuesEn;
  final Iterable<String Function(T)> filterValuesEs;
  final bool enable;
  final void Function(T) onSelected;
  final void Function(String)? onChanged;
  final TextEditingController? textController;

  const SentenceItemField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.filterValuesEn = const [],
    this.filterValuesEs = const [],
    this.enable = true,
    required this.onSelected,
    required this.onChanged,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final textController = this.textController ?? TextEditingController();
    textController.text = value != null ? safe(value) : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: RawAutocomplete<T>(
        displayStringForOption: displayStringForOption,
        focusNode: FocusNode(),
        textEditingController: textController,
        optionsBuilder: optionsBuilder,
        onSelected: onSelected,
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            keyboardType: TextInputType.none,
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              label: Text(label),
              suffixIcon: IconButton(
                onPressed: () => onClear(textEditingController),
                icon: const Icon(Icons.clear),
              ),
            ),
            validator: validator,
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
                        subtitle: Text(
                            '${filterValuesEn.map((f) => f(option)).join(',')}\n'
                            '${filterValuesEs.map((f) => f(option)).join(',')}'),
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

  String safe(T? value) => value == null ? '' : displayStringForOption(value);

  void onClear(TextEditingController textController) {
    textController.clear();
    if (onChanged != null) onChanged!('');
  }

  Iterable<T> optionsBuilder(TextEditingValue textValue) =>
      textValue.text == '' ? options : filter(textValue.text.toLowerCase());

  Iterable<T> filter(String text) => options.where((T e) =>
      [...filterValuesEn, ...filterValuesEs].any((f) => f(e).contains(text)));

  String? validator(String? value) =>
      isOptionFound(value) ? null : 'Choose a valid $label';

  bool isOptionFound(String? value) => value == null
      ? false
      : options.any((option) => displayStringForOption(option) == value);
}
