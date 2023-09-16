import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/verb/any_verb.dart';

class ClauseText extends StatelessWidget {
  final IndependentClause clause;

  const ClauseText({
    super.key,
    required this.clause,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final firstAuxiliary = clause.auxiliaries.first;
    final secondAuxiliary = clause.auxiliaries.elementAtOrNull(1);
    final thirdAuxiliary = clause.auxiliaries.elementAtOrNull(2);

    final firstAuxiliaryVerbSpan = TextSpan(
        text: firstAuxiliary == null? '<FirstAuxiliaryVerb> ' : '$firstAuxiliary ',
        style: (firstAuxiliary == null)? unsetTextStyle
            : TextStyle(color: IndependentClausePartColor.verb.color)
    );

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          if(!clause.settings.isInterrogative) TextSpan(
              text: '${clause.safeFrontAdverb} ',
              style: (clause.frontAdverb == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
          if(clause.settings.isInterrogative) firstAuxiliaryVerbSpan,
          TextSpan(
              text: '${clause.safeSubject}${clause.isContractionActive? '': ' '}',
              style: (clause.subject == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          if(!clause.settings.isInterrogative) firstAuxiliaryVerbSpan,
          TextSpan(
              text: '${clause.safeMiddleAdverb} ',
              style: (clause.midAdverb == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
          if (secondAuxiliary != null) TextSpan(
              text: '$secondAuxiliary ',
              style: TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          if (thirdAuxiliary != null) TextSpan(
              text: '$thirdAuxiliary ',
              style: TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          if(!clause.isBeAuxiliary) TextSpan(
              text: '${AnyVerb.verbToString(clause.safeVerb, clause.safeSubject, clause.settings)} ',
              style: (clause.verb == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          if (clause.safeVerb.isDitransitive) TextSpan(
              text: '${clause.safeIndirectObject} ',
              style: (clause.indirectObject == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          if (clause.safeVerb.isTransitive) TextSpan(
              text: '${clause.safeDirectObject} ',
              style: (clause.directObject == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          if (clause.safeVerb.isLinkingVerb) TextSpan(
              text: '${clause.safeSubjectComplement} ',
              style: (clause.subjectComplement == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          TextSpan(
              text: '${clause.safeEndAdverb}',
              style: (clause.endAdverb == null)? unsetTextStyle
                  : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
          if(clause.settings.isInterrogative) const TextSpan(
              text: '?',
              style: unsetTextStyle
          ),
        ],
      ),
    );
  }
}
