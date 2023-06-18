import 'package:english_app/src/model/phrases/noun_phrase.dart';
import 'package:english_app/src/widget/clause_builder/relative_clause_builder.dart';
import 'package:flutter/material.dart';

import '../../model/clauses/noun_clause.dart';
import '../../model/clauses/adjective_clause.dart';
import '../../model/common/nullable.dart';
import '../../model/phrases/gerund_phrase.dart';
import '../../model/phrases/infinitive_phrase.dart';
import '../../model/phrases/noun_phrase_and_post_modifier.dart';
import '../../model/phrases/past_participle_phrase.dart';
import '../../model/phrases/prepositional_phrase.dart';
import '../../model/phrases/participle_phrase.dart';
import '../../model/preposition.dart';
import '../../service/vocabulary_service.dart';
import '../clause_builder/noun_clause_builder.dart';
import '../common/nullable_autocomplete_word.dart';
import '../common/nullable_dropdown.dart';
import '../common/phrase_builder_card.dart';
import '../pronoun_builder.dart';
import 'gerund_phrase_builder.dart';
import 'infinitive_phrase_builder.dart';
import 'noun_phrase_builder.dart';
import 'past_participle_phrase_builder.dart';
import 'present_participle_phrase_builder.dart';

class PrepositionalPhraseBuilder extends StatelessWidget {
  PrepositionalPhraseBuilder({
    super.key,
    this.phrase,
    required this.setPhrase,
  });

  PrepositionalPhrase? phrase;
  Function(PrepositionalPhrase) setPhrase;

  initPhrase() => phrase ?? PrepositionalPhrase();

  setPreposition(Preposition? preposition) {
    setPhrase(initPhrase().copyWith(preposition: Nullable(preposition)));
  }
  setObjectOfPrepositionType(ObjectOfPrepositionType objectOfPrepositionType) {
    setPhrase(initPhrase().copyWith(objectOfPrepositionType: objectOfPrepositionType));
  }
  setPronoun(String? pronoun) {
    setPhrase(initPhrase().copyWith(directPronoun: Nullable(pronoun)));
  }
  setNoun(String? noun) {
    setPhrase(initPhrase().copyWith(objectNoun: Nullable(noun)));
  }
  setNounPhrase(NounPhraseAndPostModifier? nounPhrase) {
    setPhrase(initPhrase().copyWith(directNounPhrase: Nullable(nounPhrase)));
  }
  setGerund(String? gerund) {
    setPhrase(initPhrase().copyWith(objectGerund: Nullable(gerund)));
  }
  setGerundPhrase(GerundPhrase? gerundPhrase) {
    setPhrase(initPhrase().copyWith(objectGerundPhrase: Nullable(gerundPhrase)));
  }
  setNounClause(NounClause? nounClause) {
    setPhrase(initPhrase().copyWith(nounClause: Nullable(nounClause)));
  }
  setModifierType(PrepositionalPhraseModifierType? modifierType) {
    setPhrase(initPhrase().copyWith(modifierType: Nullable(modifierType)));
  }
  setModifierPrepositionalPhrase(PrepositionalPhrase? prepositionalPhrase) {
    setPhrase(initPhrase().copyWith(directPrepositionalPhrase: Nullable(prepositionalPhrase)));
  }
  setModifierPresentParticiplePhrase(PresentParticiplePhrase? presentParticiplePhrase) {
    setPhrase(initPhrase().copyWith(modifierPresentParticiplePhrase: Nullable(presentParticiplePhrase)));
  }
  setModifierPastParticiplePhrase(PastParticiplePhrase? pastParticiplePhrase) {
    setPhrase(initPhrase().copyWith(modifierPastParticiplePhrase: Nullable(pastParticiplePhrase)));
  }
  setModifierInfinitivePhrase(InfinitivePhrase? infinitivePhrase) {
    setPhrase(initPhrase().copyWith(modifierInfinitivePhrase: Nullable(infinitivePhrase)));
  }
  setModifierRelativeClause(AdjectiveClause? relativeClause) {
    setPhrase(initPhrase().copyWith(modifierRelativeClause: Nullable(relativeClause)));
  }

  @override
  Widget build(BuildContext context) {
    List<ObjectOfPrepositionType> objectOfPrepositions = ObjectOfPrepositionType.values;
    List<Preposition> prepositions = [Preposition(value: 'of', type: PrepositionType.space)];
    List<String> pronouns = VocabularyService.doers;
    initObjectOfPreposition(ObjectOfPrepositionType value) {
      if(value == ObjectOfPrepositionType.nounPhrase && phrase?.objectNounPhrase == null){
        setNounPhrase(NounPhraseAndPostModifier(nounPhrase: NounPhrase()));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NullableAutocompleteWord<Preposition>(
          label: 'Preposition',
          value: phrase?.preposition,
          setValue: setPreposition,
          options: prepositions,
          valueToString: (preposition) => preposition.value,
        ),
        PhraseBuilderCard(
          children: [
            Row(
              children: [
                const Text('Object of preposition'),
                const SizedBox(width: 8),
                DropdownButton<ObjectOfPrepositionType>(
                  value: ObjectOfPrepositionType.pronoun,
                  onChanged: (ObjectOfPrepositionType? value) {
                    setObjectOfPrepositionType(value!);
                    initObjectOfPreposition(value);
                  },
                  items: objectOfPrepositions.map<DropdownMenuItem<ObjectOfPrepositionType>>((ObjectOfPrepositionType item) {
                    return DropdownMenuItem<ObjectOfPrepositionType>(
                      value: item,
                      child: Text(item.name),
                    );
                  }).toList(),
                ),
              ],
            ),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.pronoun)
              PronounBuilder(
                  pronoun: phrase?.objectPronoun,
                  setPronoun: setPronoun,
                  pronouns: pronouns
              ),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.noun)
              const Text('Noun builder'),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.nounPhrase)
              NounPhraseBuilder(
                phrase: phrase?.objectNounPhrase,
                setPhrase: setNounPhrase,
              ),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.gerund)
              const Text('Gerund builder'),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.gerundPhase)
              GerundPhraseBuilder(
                phrase: phrase?.objectGerundPhrase,
                setPhrase: setGerundPhrase,
              ),
            if(phrase?.objectOfPrepositionType == ObjectOfPrepositionType.nounClause)
              NounClauseBuilder(
                clause: phrase?.objectNounClause,
                setClause: setNounClause,
              ),
          ],
        ),
        PhraseBuilderCard(
          options: [
            NullableDropdown(
              value: phrase?.modifierType,
              setValue: setModifierType,
              options: PrepositionalPhraseModifierType.values,
              optionToString: (modifierType) => modifierType.name,
              labelNull: 'Disable post modifier',
            )
          ],
          children: [
            if(phrase?.modifierType == PrepositionalPhraseModifierType.prepositionalPhrase)
              PrepositionalPhraseBuilder(
                phrase: phrase?.modifierPrepositionalPhrase,
                setPhrase: setModifierPrepositionalPhrase,
              ),
            if(phrase?.modifierType == PrepositionalPhraseModifierType.presentParticiplePhrase)
              PresentParticiplePhraseBuilder(
                phrase: phrase?.modifierPresentParticiplePhrase,
                setPhrase: setModifierPresentParticiplePhrase,
              ),
            if(phrase?.modifierType == PrepositionalPhraseModifierType.pastParticiplePhrase)
              PastParticiplePhraseBuilder(
                phrase: phrase?.modifierPastParticiplePhrase,
                setPhrase: setModifierPastParticiplePhrase,
              ),
            if(phrase?.modifierType == PrepositionalPhraseModifierType.infinitivePhrase)
              InfinitivePhraseBuilder(
                phrase: phrase?.modifierInfinitivePhrase,
                setPhrase: setModifierInfinitivePhrase,
              ),
            if(phrase?.modifierType == PrepositionalPhraseModifierType.relativeClause)
              RelativeClauseBuilder(
                clause: phrase?.modifierRelativeClause,
                setClause: setModifierRelativeClause,
              ),
          ],
        ),
      ],
    );
  }
}
