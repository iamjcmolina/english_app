import 'package:flutter/material.dart';

import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/adverb/value/adverb_variant.dart';
import '../../sentence_scaffold.dart';
import 'adverb_form.dart';

class AdverbPage extends StatefulWidget {
  final AdverbPosition position;
  final AnyAdverb? adverb;

  const AdverbPage({super.key, required this.position, required this.adverb});

  @override
  State<AdverbPage> createState() => _AdverbPageState();
}

class _AdverbPageState extends State<AdverbPage> {
  late AdverbVariant variant;
  late AnyAdverb? adverb;
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    adverb = widget.adverb;
    variant = switch(widget.adverb.runtimeType) {
      _ => AdverbVariant.word,
    };
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<AdverbVariant>(
          initialSelection: variant,
          label: const Text('Adverb Variant'),
          dropdownMenuEntries: AdverbVariant.values
              .map<DropdownMenuEntry<AdverbVariant>>(
                  (AdverbVariant item) => DropdownMenuEntry<AdverbVariant>(
                value: item,
                label: item.name,
              )).toList(),
          onSelected: (AdverbVariant? item) => setVariant(item!),
        ),
      ),
    );

    return SentenceScaffold(
      title: 'Independent Clause',
      bottomActions: [
        IconButton(
            onPressed: canSave? () => Navigator.pop(context, adverb) : null,
            icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch(variant) {
        _ => AdverbForm(
          settingsControl: settingsControl,
          position: widget.position,
          adverb: adverb is Adverb? adverb as Adverb : null,
          setAdverb: setAdverb,
          setCanSave: setCanSave,
        ),
      }
    );
  }

  setAdverb(AnyAdverb? adverb) => setState(() => this.adverb = adverb as Adverb?);

  setVariant(AdverbVariant variant) => setState(() => this.variant = variant);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);
}
