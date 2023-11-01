import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/phrasal_verb.dart';
import '../../../model/sentence_item.dart';

class ClauseText extends StatelessWidget {
  final IndependentClause clause;

  const ClauseText({
    super.key,
    required this.clause,
  });

  @override
  Widget build(BuildContext context) {
    final auxiliaryVerbs = clause.auxiliaryVerbs;

    final firstAuxiliaryVerbSpan = TextSpan(
        text: auxiliaryVerbs.first == null ? '' : '${auxiliaryVerbs.first} ',
        style: auxiliaryVerbs.first == null
            ? SentenceItem.placeholder.style
            : SentenceItem.verb.style);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          if (!clause.isInterrogative && clause.frontAdverb != null)
            TextSpan(
                text: '${clause.frontAdverb} ',
                style: SentenceItem.adverb.style),
          if (clause.isInterrogative) firstAuxiliaryVerbSpan,
          TextSpan(
              text: '${clause.subject ?? clause.subjectPlaceholder}'
                  '${clause.isVerbContractionActive ? '' : ' '}',
              style: (clause.subject == null)
                  ? SentenceItem.placeholder.style
                  : SentenceItem.noun.style),
          if (!clause.isInterrogative) firstAuxiliaryVerbSpan,
          if (clause.midAdverb != null)
            TextSpan(
                text: '${clause.midAdverb} ', style: SentenceItem.adverb.style),
          if (auxiliaryVerbs.second != null)
            TextSpan(
                text: '${auxiliaryVerbs.second} ',
                style: SentenceItem.verb.style),
          if (auxiliaryVerbs.third != null)
            TextSpan(
                text: '${auxiliaryVerbs.third} ',
                style: SentenceItem.verb.style),
          if (!clause.isBeAuxiliary)
            TextSpan(
                text: '${clause.verbAsString()} ',
                style: (clause.verb == null)
                    ? SentenceItem.placeholder.style
                    : SentenceItem.verb.style),
          if (clause.hasDitransitiveVerb && clause.indirectObject != null)
            TextSpan(
                text: '${clause.indirectObject} ',
                style: SentenceItem.noun.style),
          if (clause.hasTransitiveVerb && clause.directObject != null)
            TextSpan(
                text: '${clause.directObject} ',
                style: SentenceItem.noun.style),
          if (clause.verb is PhrasalVerb)
            TextSpan(
                text: '${(clause.verb as PhrasalVerb).particle} ',
                style: SentenceItem.verb.style),
          if (clause.hasLinkingVerb && clause.subjectComplement != null)
            TextSpan(
                text: '${clause.subjectComplement} ',
                style: SentenceItem.noun.style),
          if (clause.endAdverb != null)
            TextSpan(
                text: '${clause.endAdverb}', style: SentenceItem.adverb.style),
          if (clause.isInterrogative) const TextSpan(text: '?'),
        ],
      ),
    );
  }
}
