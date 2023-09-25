import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/adverb/value/adverb_variant.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../service/vocabulary_service.dart';
import '../sentence_item_field.dart';
import '../../root_layout.dart';

class AdverbPage extends StatefulWidget {
  final AnyAdverb? adverb;
  final AdverbPosition position;

  const AdverbPage({super.key, this.adverb, required this.position});

  @override
  State<AdverbPage> createState() => _AdverbPageState();
}

class _AdverbPageState extends State<AdverbPage> {
  late AdverbVariant adverbVariant;
  late Adverb? adverb;
  bool editingSettings = false;
  bool isBottomAppBarShown = false;
  bool editingVerb = false;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<AnyAdverb> adverbs = switch(widget.position) {
      AdverbPosition.front => vocabularyService.frontAdverbs(),
      AdverbPosition.mid => vocabularyService.midAdverbs(),
      _ => vocabularyService.endAdverbs(),
    };

    String label = switch(widget.position){
      AdverbPosition.front => '<FrontAdverb>',
      AdverbPosition.mid => '<MidAdverb>',
      _ => '<EndAdverb>',
    };

    const unsetTextStyle = TextStyle(fontSize: 12);

    return RootLayout(
      title: 'Independent Clause',
      showBottomAppBar: isBottomAppBarShown,
      bottomAppBarChildren: [
        IconButton(
            onPressed: () => onSavePage(context),
            icon: const Icon(Icons.save)
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => index = index == 0? 1 : 0),
                    child: const Icon(Icons.chevron_left),
                  ),
                  IndexedStack(
                    index: index,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<AdverbVariant>(
                          initialSelection: adverbVariant,
                          label: const Text('Adverb Variant'),
                          dropdownMenuEntries: AdverbVariant.values
                              .map<DropdownMenuEntry<AdverbVariant>>(
                                  (AdverbVariant item) => DropdownMenuEntry<AdverbVariant>(
                                value: item,
                                label: item.name,
                              )).toList(),
                          onSelected: (AdverbVariant? item) => setAdverbVariant(item!),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => setState(() => index = index == 0? 1 : 0),
                    child: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: '${adverb ?? label}',
                      style: (adverb == null)? unsetTextStyle
                          : TextStyle(color: IndependentClausePartColor.adverb.color)
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      SentenceItemField<AnyAdverb>(
                        label: label,
                        value: adverb,
                        options: adverbs,
                        onSelected: onAdverbSelected,
                        onCleaned: () => onAdverbCleaned(),
                        onChanged: (text) => onAdverbChanged(),
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

  void onAdverbSelected(AnyAdverb adverb) {
    setAdverb(adverb);
    showOrHideBottomAppBar();
  }

  onAdverbCleaned() {
    onAdverbChanged();
  }

  onAdverbChanged() {
    setAdverb(null);
    showOrHideBottomAppBar();
  }

  setAdverb(AnyAdverb? adverb) => setState(()=> this.adverb = adverb as Adverb?);

  setAdverbVariant(AdverbVariant variant) => setState(()=> adverbVariant = variant);

  onSavePage(BuildContext context) => Navigator.pop(context, adverb);

  showOrHideBottomAppBar() => setState(() => isBottomAppBarShown = adverb != null);

  AdverbVariant get variant => switch(widget.adverb.runtimeType) {
    Adverb => AdverbVariant.word,
    _ => AdverbVariant.word,
  };

  @override
  void initState() {
    super.initState();
    adverb = (widget.adverb is Adverb? widget.adverb : null) as Adverb?;
    adverbVariant = variant;
  }
}
