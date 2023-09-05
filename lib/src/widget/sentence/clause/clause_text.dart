import 'package:flutter/material.dart';

import '../../../model/sentence/clause/value/independent_clause_part_color.dart';

class ClauseText extends StatelessWidget {
  final String? frontAdverb;
  final String? subject;
  final String? firstAuxiliaryVerb;
  final String? middleAdverb;
  final String? secondAuxiliaryVerb;
  final String? thirdAuxiliaryVerb;
  final String? verb;
  final String? indirectObject;
  final String? directObject;
  final String? subjectComplement;
  final String? endAdverb;

  const ClauseText({
    super.key,
    this.frontAdverb,
    this.subject,
    this.firstAuxiliaryVerb,
    this.middleAdverb,
    this.secondAuxiliaryVerb,
    this.thirdAuxiliaryVerb,
    this.verb,
    this.indirectObject,
    this.directObject,
    this.subjectComplement,
    this.endAdverb,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: frontAdverb == null? '<FrontAdverb> ' : '$frontAdverb ',
              style: (frontAdverb == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
          TextSpan(
              text: subject == null? '<Subject> ' : '$subject ',
              style: (subject == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          TextSpan(
              text: firstAuxiliaryVerb == null? '<FirstAuxiliaryVerb> ' : '$firstAuxiliaryVerb ',
              style: (firstAuxiliaryVerb == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          TextSpan(
              text: middleAdverb == null? '<MiddleAdverb> ' : '$middleAdverb ',
              style: (middleAdverb == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
          if (secondAuxiliaryVerb != null) TextSpan(
              text: '$secondAuxiliaryVerb ',
              style: TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          if (thirdAuxiliaryVerb != null) TextSpan(
              text: '$thirdAuxiliaryVerb ',
              style: TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          TextSpan(
              text: verb == null? '<Verb> ' : '$verb ',
              style: (verb == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.verb.color)
          ),
          if (indirectObject != null) TextSpan(
              text: '$indirectObject ',
              style: TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          if (directObject != null) TextSpan(
              text: '$directObject ',
              style: TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          if (subjectComplement != null) TextSpan(
              text: '$subjectComplement ',
              style: TextStyle(color: IndependentClausePartColor.noun.color)
          ),
          TextSpan(
              text: endAdverb == null? '<EndAdverb> ' : '$endAdverb ',
              style: (endAdverb == null)? unsetTextStyle : TextStyle(color: IndependentClausePartColor.adverb.color)
          ),
        ],
      ),
    );
  }
}
