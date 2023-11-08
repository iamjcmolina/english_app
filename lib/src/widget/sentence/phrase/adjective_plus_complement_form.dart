import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adjective/adjective_complement.dart';
import '../../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import '../../page/adjective_complement_page.dart';

class AdjectivePlusComplementForm extends StatefulWidget {
  final Widget settingsControl;
  final AdjectivePlusComplement phrase;
  final void Function(AdjectivePlusComplement?) setPhrase;
  final bool isPlural;
  final bool isNegative;

  const AdjectivePlusComplementForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isPlural,
    required this.isNegative,
  });

  @override
  State<AdjectivePlusComplementForm> createState() =>
      _AdjectivePlusComplementFormState();
}

class _AdjectivePlusComplementFormState
    extends State<AdjectivePlusComplementForm> {
  bool isAdjectiveFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        widget.settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text:
                    (widget.phrase.adjective?.en ?? Label.adjective).addSpace(),
                style: widget.phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
              TextSpan(
                text:
                    (widget.phrase.complement?.en ?? Label.adjectiveComplement)
                        .addSpace(),
                style: widget.phrase.complement == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: (widget.phrase.adjective?.toEs() ?? Label.adjectiveEs)
                    .addSpace(),
                style: widget.phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
              TextSpan(
                text: (widget.phrase.complement?.es ??
                        Label.adjectiveComplementEs)
                    .addSpace(),
                style: widget.phrase.complement == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        if (!isAdjectiveFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleAdjectiveField,
            style: Word.adjective.style,
            placeholder: Label.adjective,
            en: widget.phrase.adjective?.en,
            es: widget.phrase.adjective?.toEs(widget.isPlural),
            isRequired: true,
          ),
        if (isAdjectiveFieldShown)
          ItemField<Adjective>(
            label: Label.adjective,
            options: vocabularyRepository.adjectives(),
            value: widget.phrase.adjective,
            setValue: setAdjective,
            toEnString: (e) => e.en,
            toEsString: (e) => e.toEs(widget.isPlural),
            onAccept: toggleAdjectiveField,
          ),
        ItemTile(
          style: Word.adjective.style,
          placeholder: Label.adjectiveComplement,
          en: widget.phrase.complement?.en,
          es: widget.phrase.complement?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToComplementPage(context),
        ),
      ],
    );
  }

  void setAdjective(Adjective? adjective) =>
      widget.setPhrase(widget.phrase.copyWith(adjective: Nullable(adjective)));

  void setComplement(AdjectiveComplement? complement) => widget
      .setPhrase(widget.phrase.copyWith(complement: Nullable(complement)));

  void goToComplementPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdjectiveComplementPage(
                  complement: widget.phrase.complement,
                  isNegative: widget.isNegative,
                  isPlural: widget.isPlural,
                )));
    if (response != null) {
      setComplement(response is AdjectiveComplement ? response : null);
    }
  }

  toggleAdjectiveField() =>
      setState(() => isAdjectiveFieldShown = !isAdjectiveFieldShown);
}
