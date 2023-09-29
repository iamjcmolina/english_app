import 'package:flutter/material.dart';

import '../../../model/sentence/noun/pronoun.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class PronounForm extends StatefulWidget {
  final List<Pronoun> pronouns;
  final void Function(Pronoun?) setPronoun;
  final Pronoun? pronoun;
  final Function(bool) setShowBottomAppBar;

  const PronounForm({
    super.key,
    required this.pronouns,
    required this.setPronoun,
    required this.setShowBottomAppBar,
    this.pronoun,
  });

  @override
  State<PronounForm> createState() => _PronounFormState();
}

class _PronounFormState extends State<PronounForm> {
  bool settingPronoun = false;

  @override
  Widget build(BuildContext context) {
    const Color pronounColor = Colors.deepPurpleAccent;

    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.pronoun == null? '<Pronoun>' : widget.pronoun.toString(),
              style: const TextStyle(color: pronounColor),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      if(!settingPronoun) SentenceItemTile(
                        color: pronounColor,
                        label: 'Pronoun',
                        value: widget.pronoun?.value,
                        trailing: const Icon(Icons.edit),
                        onTap: () => toggleSettingPronoun(),
                      ),
                      if(settingPronoun) SentenceItemField<Pronoun>(
                          label: 'Pronoun',
                          value: widget.pronoun,
                          options: widget.pronouns,
                          displayStringForOption: (pronoun) => pronoun.value,
                          onSelected: onPronounSelected,
                          onChanged: (text) => onPronounChanged(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onPronounSelected(Pronoun pronoun) {
    widget.setPronoun(pronoun);
    toggleSettingPronoun();
    widget.setShowBottomAppBar(true);
  }

  onPronounChanged() {
    widget.setPronoun(null);
    widget.setShowBottomAppBar(false);
  }

  toggleSettingPronoun() => setState(() => settingPronoun = !settingPronoun);

  @override
  void initState() {
    super.initState();
  }
}
