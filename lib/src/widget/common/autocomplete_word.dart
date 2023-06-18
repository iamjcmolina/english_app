import 'package:flutter/material.dart';

class AutocompleteWord<T extends Object> extends StatelessWidget {
  final String label;
  final T? value;
  final void Function(T?) setValue;
  final List<T> options;
  final String Function(T) valueToString;
  final bool enable;

  AutocompleteWord({
    super.key,
    required this.label,
    required this.value,
    required this.setValue,
    required this.options,
    required this.valueToString,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    String nullableValueToString(T? value) => (value == null)? '' : valueToString(value);
    optionFound(value) => options.any((option) => nullableValueToString(option) == value);

    bool isNullValue = value == null;

    return TextButton(
      onPressed: !enable? null : () {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: Autocomplete<T>(
                    initialValue: value != null? TextEditingValue(text: nullableValueToString(value)) : null,
                    displayStringForOption: valueToString,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return options;
                      }
                      return options.where((T option) {
                        return nullableValueToString(option).contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (T selection) {
                      setValue(selection);
                      Navigator.pop(context);
                    },
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
                              setValue(null);
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        validator: (value) {
                          if (!optionFound(value)) {
                            return 'Choose a valid $label';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value){
                          if(!optionFound(value)){
                            setValue(null);
                          }
                        },
                      );
                    }
                ),
              ),
        );
      },
      child: Column(
        children: [
          Text(
              isNullValue? 'Not set' : nullableValueToString(value),
              style: isNullValue? const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                  : !enable? const TextStyle(color: Colors.grey)
                  : null
          ),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey),),
        ],
      ),
    );
  }
}
