import 'package:flutter/material.dart';

class ItemField<T extends Object> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? value;
  final void Function(T?) setValue;
  final String Function(T) toEnString;
  final String Function(T) toEsString;
  final void Function()? onAccept;
  final String Function(T)? getHelperText;
  final bool autofocus;
  final bool isEnabled;
  final TextEditingController? controller;

  String? get helperText =>
      getHelperText == null || value == null ? null : getHelperText!(value!);

  const ItemField({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.setValue,
    required this.toEnString,
    required this.toEsString,
    this.onAccept,
    this.getHelperText,
    this.autofocus = true,
    this.isEnabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? TextEditingController();
    controller.text = safe(value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: RawAutocomplete<T>(
        displayStringForOption: toEnString,
        focusNode: FocusNode(),
        textEditingController: controller,
        optionsBuilder: optionsBuilder,
        onSelected: (value) {
          setValue(value);
          if (onAccept != null) onAccept!();
        },
        fieldViewBuilder: (_, controller, focusNode, onFieldSubmitted) =>
            TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              label: Text(label),
              helperText: helperText,
              prefixIcon: onAccept == null
                  ? null
                  : IconButton(
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          setValue(null);
                        }
                        onAccept!();
                      },
                      icon: const Icon(Icons.done),
                    ),
              suffixIcon: IconButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    setValue(null);
                  }
                  controller.text = '';
                },
                icon: const Icon(Icons.clear),
              )),
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          scrollPadding: const EdgeInsets.only(bottom: 200),
          autofocus: autofocus,
        ),
        optionsViewBuilder: (_, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              width: 350,
              height: 180.0,
              child: ListView.separated(
                padding: const EdgeInsets.all(0.0),
                itemCount: options.length,
                itemBuilder: (_, int index) {
                  final T option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: ListTile(
                      title: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: toEnString(option),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' (${toEsString(option)})'),
                      ])),
                      subtitle: getHelperText == null
                          ? null
                          : Text(getHelperText!(option)),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String safe(T? value) => value == null ? '' : toEnString(value);

  Iterable<T> optionsBuilder(TextEditingValue editingValue) =>
      editingValue.text == ''
          ? options
          : options
              .where((T option) => optionContains(option, editingValue.text));

  String? validator(String? text) =>
      optionExist(text) ? null : 'Choose a valid $label';

  bool optionExist(String? text) =>
      options.any((T option) => optionContains(option, text));

  bool optionContains(T option, String? text) => text == null
      ? false
      : toEnString(option).toLowerCase().contains(text.toLowerCase()) ||
          toEsString(option).toLowerCase().contains(text.toLowerCase());
}
