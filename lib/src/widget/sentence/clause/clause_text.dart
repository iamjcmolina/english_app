import 'package:flutter/material.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/phrasal_verb.dart';
import '../../../model/word.dart';

class ClauseText extends StatelessWidget {
  final IndependentClause clause;

  const ClauseText({super.key, required this.clause});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_ClauseTextEn(clause), _ClauseTextEs(clause)],
    );
  }
}

class _ClauseTextEn extends StatelessWidget {
  final IndependentClause clause;

  const _ClauseTextEn(this.clause);

  @override
  Widget build(BuildContext context) {
    final aux = clause.auxiliaryVerbs;

    final firstAuxiliaryVerbSpan = TextSpan(
        text: aux.first?.addSpace(),
        style: aux.first == null ? Word.empty.style : Word.verb.style);

    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: !clause.isInterrogative
                ? clause.frontAdverb?.en.addSpace()
                : null,
            style: Word.adverb.style),
        if (clause.isInterrogative) firstAuxiliaryVerbSpan,
        TextSpan(
            text: (clause.subject?.en ?? Label.subject)
                .addSpace(!clause.isVerbContractionActive),
            style: clause.subject == null ? Word.empty.style : Word.noun.style),
        if (!clause.isInterrogative) firstAuxiliaryVerbSpan,
        TextSpan(
            text: clause.midAdverb?.en.addSpace(), style: Word.adverb.style),
        TextSpan(text: aux.second?.addSpace(), style: Word.verb.style),
        TextSpan(text: aux.third?.addSpace(), style: Word.verb.style),
        TextSpan(
            text: clause.isBeAuxiliary
                ? null
                : (clause.conjugateVerb() ?? clause.verbPlaceholder).addSpace(),
            style: clause.verb == null ? Word.empty.style : Word.verb.style),
        TextSpan(
            text: clause.hasDitransitiveVerb
                ? clause.indirectObject?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.hasTransitiveVerb
                ? clause.directObject?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.verb is PhrasalVerb
                ? (clause.verb as PhrasalVerb).particle.addSpace()
                : null,
            style: Word.verb.style),
        TextSpan(
            text: clause.hasLinkingVerb
                ? clause.subjectComplement?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(text: clause.endAdverb?.en, style: Word.adverb.style),
        TextSpan(text: clause.isInterrogative ? '?' : null),
      ],
    ));
  }
}

class _ClauseTextEs extends StatelessWidget {
  final IndependentClause clause;

  const _ClauseTextEs(this.clause);

  @override
  Widget build(BuildContext context) {
    final aux = clause.auxiliaryVerbs;

    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: !clause.isInterrogative
                ? clause.frontAdverb?.es.addSpace()
                : null,
            style: Word.adverb.style),
        TextSpan(
            text: (clause.subject?.es ?? Label.subjectEs).addSpace(),
            style: clause.subject == null ? Word.empty.style : Word.noun.style),
        TextSpan(
            text: clause.midAdverb?.es.addSpace(), style: Word.adverb.style),
        TextSpan(
            text: aux.firstEs?.addSpace(aux.firstEs!.isNotEmpty),
            style: aux.firstEs == null ? Word.empty.style : Word.verb.style),
        TextSpan(text: aux.secondEs?.addSpace(), style: Word.verb.style),
        TextSpan(text: aux.thirdEs?.addSpace(), style: Word.verb.style),
        TextSpan(
            text: clause.isBeAuxiliary
                ? null
                : (clause.conjugateVerbEs() ?? clause.verbPlaceholderEs)
                    .addSpace(),
            style: clause.verb == null ? Word.empty.style : Word.verb.style),
        TextSpan(
            text: clause.hasDitransitiveVerb
                ? clause.indirectObject?.es.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.hasTransitiveVerb
                ? clause.directObject?.es.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.hasLinkingVerb
                ? clause.subjectComplement?.es.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(text: clause.endAdverb?.es, style: Word.adverb.style),
        TextSpan(text: clause.isInterrogative ? '?' : null),
      ],
    ));
  }
}
