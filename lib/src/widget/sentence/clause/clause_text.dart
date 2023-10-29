import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/verb/phrasal-verb.dart';

class ClauseText extends StatelessWidget {
  final IndependentClause clause;

  const ClauseText({
    super.key,
    required this.clause,
  });

  @override
  Widget build(BuildContext context) {
    final auxiliaryVerbs = clause.auxiliaryVerbs;

    const unsetTextStyle = TextStyle(fontSize: 12);

    final firstAuxiliaryVerbSpan = TextSpan(
        text: auxiliaryVerbs.first == null ? '' : '${auxiliaryVerbs.first} ',
        style: (auxiliaryVerbs.first == null)
            ? unsetTextStyle
            : TextStyle(color: SentenceItem.verb.color));

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          if (!clause.isInterrogative && clause.frontAdverb != null)
            TextSpan(
                text: '${clause.frontAdverb} ',
                style: TextStyle(color: SentenceItem.adverb.color)),
          if (clause.isInterrogative) firstAuxiliaryVerbSpan,
          TextSpan(
              text: '${clause.subject ?? clause.subjectPlaceholder}'
                  '${clause.isVerbContractionActive ? '' : ' '}',
              style: (clause.subject == null)
                  ? unsetTextStyle
                  : TextStyle(color: SentenceItem.noun.color)),
          if (!clause.isInterrogative) firstAuxiliaryVerbSpan,
          if (clause.midAdverb != null)
            TextSpan(
                text: '${clause.midAdverb} ',
                style: TextStyle(color: SentenceItem.adverb.color)),
          if (auxiliaryVerbs.second != null)
            TextSpan(
                text: '${auxiliaryVerbs.second} ',
                style: TextStyle(color: SentenceItem.verb.color)),
          if (auxiliaryVerbs.third != null)
            TextSpan(
                text: '${auxiliaryVerbs.third} ',
                style: TextStyle(color: SentenceItem.verb.color)),
          if (!clause.isBeAuxiliary)
            TextSpan(
                text: '${clause.verbAsString()} ',
                style: (clause.verb == null)
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.verb.color)),
          if (clause.hasDitransitiveVerb && clause.indirectObject != null)
            TextSpan(
                text: '${clause.indirectObject} ',
                style: TextStyle(color: SentenceItem.noun.color)),
          if (clause.hasTransitiveVerb && clause.directObject != null)
            TextSpan(
                text: '${clause.directObject} ',
                style: TextStyle(color: SentenceItem.noun.color)),
          if (clause.verb is PhrasalVerb)
            TextSpan(
                text: '${(clause.verb as PhrasalVerb).particle} ',
                style: TextStyle(color: SentenceItem.verb.color)),
          if (clause.hasLinkingVerb && clause.subjectComplement != null)
            TextSpan(
                text: '${clause.subjectComplement} ',
                style: TextStyle(color: SentenceItem.noun.color)),
          if (clause.endAdverb != null)
            TextSpan(
                text: '${clause.endAdverb}',
                style: TextStyle(color: SentenceItem.adverb.color)),
          if (clause.isInterrogative) const TextSpan(text: '?'),
        ],
      ),
    );
  }
}
