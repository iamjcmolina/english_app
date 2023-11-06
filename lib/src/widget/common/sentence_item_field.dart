import 'package:flutter/material.dart';

class SentenceItemField<T extends Object> extends StatelessWidget {
  final String label;
  final T? value;
  final void Function(T?) setValue;
  final List<T> options;
  final Iterable<String Function(T)> getEnWords;
  final Iterable<String Function(T)> getEsWords;
  final String Function(T) displayStringForOption;
  final void Function()? onSelected;
  final TextEditingController? textController;
  final bool enable;

  const SentenceItemField({
    super.key,
    required this.label,
    required this.value,
    required this.displayStringForOption,
    required this.setValue,
    required this.options,
    this.getEnWords = const [],
    this.getEsWords = const [],
    this.onSelected,
    this.textController,
    this.enable = true,
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
        onSelected: (T value) {
          setValue(value);
          if (onSelected != null) {
            onSelected!();
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => onClear(textEditingController),
                icon: const Icon(Icons.clear),
              ),
            ),
            validator: validator,
            autovalidateMode: AutovalidateMode.always,
            //onChanged: (text) => setValue(null),
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
                        title: Text(getEnWords
                            .map(
                                (String Function(T) getWord) => getWord(option))
                            .join(',')),
                        subtitle: Text(getEsWords
                            .map(
                                (String Function(T) getWord) => getWord(option))
                            .where((String e) => e.isNotEmpty)
                            .join(',')),
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
    setValue(null);
  }

  Iterable<T> optionsBuilder(TextEditingValue editingValue) =>
      editingValue.text == ''
          ? options
          : options.where((T option) => <String Function(T)>[
                ...getEnWords,
                ...getEsWords
              ].any((String Function(T) getWord) => getWord(option)
                  .toLowerCase()
                  .contains(editingValue.text.toLowerCase())));

  String? validator(String? value) =>
      isOptionFound(value) ? null : 'Choose a valid $label';

  bool isOptionFound(String? value) => value == null
      ? false
      : options.any((option) => displayStringForOption(option) == value);
}
