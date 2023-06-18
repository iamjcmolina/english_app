import 'package:english_app/src/model/phrases/participle_phrase.dart';
import 'package:english_app/src/widget/phrase_builder/pre_adjective_phrase_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/phrases/noun_phrase.dart';
import '../../model/clauses/adjective_clause.dart';
import '../../model/common/nullable.dart';
import '../../model/phrases/adjective_phrase.dart';
import '../../model/phrases/pre_adjective_phrase.dart';
import '../../model/phrases/infinitive_phrase.dart';
import '../../model/phrases/noun_phrase_and_post_modifier.dart';
import '../../model/phrases/past_participle_phrase.dart';
import '../../model/phrases/prepositional_phrase.dart';
import '../../model/noun.dart';
import '../../service/vocabulary_service.dart';
import '../clause_builder/relative_clause_builder.dart';
import '../common/nullable_autocomplete_word.dart';
import '../common/phrase_builder_card.dart';
import 'infinitive_phrase_builder.dart';
import 'past_participle_phrase_builder.dart';
import 'post_adjective_phrase_builder.dart';
import 'prepositional_phrase_builder.dart';
import 'present_participle_phrase_builder.dart';

class NounPhraseBuilder extends StatelessWidget {
  NounPhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  NounPhraseAndPostModifier? phrase;
  Function(NounPhraseAndPostModifier?) setPhrase;

  @override
  Widget build(BuildContext context) {
    final Noun? noun = phrase?.nounPhrase.noun;
    final vocabularyService = Provider.of<VocabularyService>(context);
    List<String> determiners = [];
    if (noun != null) {
      determiners = vocabularyService.determiners(noun);
    }
    final nouns = vocabularyService.nouns();
    //final PrepositionalPhrase prepositionalPhrase = phrase.prepositionalPhrase;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (noun != null) NullableAutocompleteWord<String>(
          label: 'Determiner',
          value: phrase?.nounPhrase.determiner,
          setValue: setDeterminer,
          options: determiners,
          valueToString: (determiner) => determiner,
        ),
        if (noun != null) PhraseBuilderCard(
          options: [
            DropdownButton<AdjectiveType?>(
              value: phrase?.nounPhrase.adjectiveType,
              onChanged: (AdjectiveType? value) {
                setAdjectiveType(value);
              },
              items: [
                const DropdownMenuItem<AdjectiveType?>(
                  value: null,
                  child: Text('Disable Adjective', style: TextStyle(color: Colors.black26,fontSize: 12),),
                ),
                ...AdjectiveType.values.map<DropdownMenuItem<AdjectiveType?>>((AdjectiveType? item) {
                  return DropdownMenuItem<AdjectiveType?>(
                    value: item,
                    child: Text(item!.name),
                  );
                }).toList()
              ],
            ),
          ],
          children: [
            if (phrase?.nounPhrase.adjectiveType == AdjectiveType.adjective) AdjectivesBuilder(
              adjectives: phrase?.nounPhrase.adjectives ?? [],
              setAdjectives: setAdjectives,
            ),
            if (phrase?.nounPhrase.adjectiveType == AdjectiveType.adjectivePhrase)
              PreAdjectivePhraseBuilder(
                  phrase: phrase?.nounPhrase.preAdjectivePhrase,
                  setPhrase: setPreAdjectivePhrase
              ),
          ],
        ),
        NullableAutocompleteWord<Noun>(
          label: 'Noun',
          value: phrase?.nounPhrase.noun,
          setValue: setNoun,
          options: nouns,
          valueToString: (noun) => noun.value,
        ),
        PhraseBuilderCard(
          options: [
            DropdownButton<NounPostModifierType?>(
              value: phrase?.postModifierType,
              onChanged: (NounPostModifierType? value) {
                setPostModifierType(value);
                if(value == null) {
                  setPrepositionalPhrase(null);
                }
              },
              items: [
                const DropdownMenuItem<NounPostModifierType?>(
                  value: null,
                  child: Text('Disable Adjectival Phrase', style: TextStyle(color: Colors.black26,fontSize: 12),),
                ),
                ...NounPostModifierType.values.map<DropdownMenuItem<NounPostModifierType?>>((NounPostModifierType? item) {
                  return DropdownMenuItem<NounPostModifierType?>(
                    value: item,
                    child: Text(item!.name),
                  );
                }).toList()
              ],
            ),
          ],
          children: [
            if(phrase?.postModifierType == NounPostModifierType.prepositionalPhrase)
              PrepositionalPhraseBuilder(
                phrase: phrase?.prepositionalPhrase,
                setPhrase: setPrepositionalPhrase,
              ),
            if(phrase?.postModifierType == NounPostModifierType.infinitivePhrase)
              InfinitivePhraseBuilder(
                phrase: phrase?.infinitivePhrase,
                setPhrase: setInfinitivePhrase,
              ),
            if(phrase?.postModifierType == NounPostModifierType.presentParticiplePhrase)
              PresentParticiplePhraseBuilder(
                phrase: phrase?.presentParticiplePhrase,
                setPhrase: setPresentParticiplePhrase,
              ),
            if(phrase?.postModifierType == NounPostModifierType.pastParticiplePhrase)
              PastParticiplePhraseBuilder(
                phrase: phrase?.pastParticiplePhrase,
                setPhrase: setPastParticiplePhrase,
              ),
            if(phrase?.postModifierType == NounPostModifierType.postAdjectivePhrase)
              PostAdjectivePhraseBuilder(
                phrase: phrase?.adjectivePhrase,
                setPhrase: setPostAdjectivePhrase,
              ),
            if(phrase?.postModifierType == NounPostModifierType.adjectiveClause)
              RelativeClauseBuilder(
                clause: phrase?.adjectiveClause,
                setClause: setRelativeClause,
              ),
          ],
        ),
        const Text('Adjective phrase'),
      ],
    );
  }

  NounPhraseAndPostModifier initPhrase() => phrase ?? NounPhraseAndPostModifier(nounPhrase: NounPhrase());

  setDeterminer(String? determiner) {
    setBareObject(initPhrase().nounPhrase.copyWith(determiner: Nullable(determiner)));
  }
  setAdjectiveType(AdjectiveType? adjectiveType) {
    setBareObject(initPhrase().nounPhrase.copyWith(adjectiveType: Nullable(adjectiveType)));
  }
  setAdjectives(List<String?> adjectives) {
    setBareObject(initPhrase().nounPhrase.copyWith(adjectives: adjectives));
  }
  setNoun(Noun? noun) {
    setBareObject(initPhrase().nounPhrase.copyWith(noun: Nullable(noun)));
  }
  setPreAdjectivePhrase(PreModifierAdjective? adjectivePhrase) {
    setBareObject(initPhrase().nounPhrase.copyWith(preAdjectivePhrase: Nullable(adjectivePhrase)));
  }
  setBareObject(NounPhrase bareObject) {
    setPhrase(initPhrase().copyWith(nounPhrase: bareObject));
  }
  setPrepositionalPhrase(PrepositionalPhrase? prepositionalPhrase) {
    setPhrase(initPhrase().copyWith(prepositionalPhrase: Nullable(prepositionalPhrase)));
  }
  setPostModifierType(NounPostModifierType? postModifierType) {
    setPhrase(initPhrase().copyWith(postModifierType: Nullable(postModifierType)));
  }
  setInfinitivePhrase(InfinitivePhrase? infinitivePhrase) {
    setPhrase(initPhrase().copyWith(infinitivePhrase: Nullable(infinitivePhrase)));
  }
  setPresentParticiplePhrase(PresentParticiplePhrase? presentParticiplePhrase) {
    setPhrase(initPhrase().copyWith(presentParticiplePhrase: Nullable(presentParticiplePhrase)));
  }
  setPastParticiplePhrase(PastParticiplePhrase? pastParticiplePhrase) {
    setPhrase(initPhrase().copyWith(pastParticiplePhrase: Nullable(pastParticiplePhrase)));
  }
  setPostAdjectivePhrase(AdjectivePhrase? postAdjectivePhrase) {
    setPhrase(initPhrase().copyWith(postAdjectivePhrase: Nullable(postAdjectivePhrase)));
  }
  setRelativeClause(AdjectiveClause? relativeClause) {
    setPhrase(initPhrase().copyWith(adjectiveClause: Nullable(relativeClause)));
  }
}

class AdjectivesBuilder extends StatelessWidget {
  AdjectivesBuilder({super.key, required this.adjectives, required this.setAdjectives});

  List<String?> adjectives;
  void Function(List<String?>) setAdjectives;

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);
    final adjectivesList = vocabularyService.adjectives();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(adjectives.isEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text('Add an adjective'),
                onPressed: (){
                  addNewAdjective();
                },
              ),
            ),
          ...adjectives.asMap().entries.map((adjectiveEntry) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NullableAutocompleteWord<String>(
                  label: 'Adjective',
                  value: adjectiveEntry.value,
                  setValue: (value) {
                    setAdjective(adjectiveEntry.key, value);
                  },
                  options: adjectivesList,
                  valueToString: (adjective) => adjective,
                ),
                IconButton(
                  onPressed: isLastAdjective(adjectiveEntry.key)? addNewAdjective : () {
                    removeAdjective(adjectiveEntry.key);
                  },
                  icon: Icon(isLastAdjective(adjectiveEntry.key)? Icons.add : Icons.remove),
                ),
              ],
            ),
          ),
        ],
    );
  }

  addNewAdjective() {
    List<String?> newAdjectives = [null, ...adjectives];
    setAdjectives(newAdjectives);
  }

  setAdjective(int index, String? adjective) {
    adjectives.removeAt(index);
    adjectives.insert(index, adjective);
    setAdjectives(adjectives);
  }

  removeAdjective(int index) {
    adjectives.removeAt(index);
    setAdjectives(adjectives);
  }

  isLastAdjective(int index) => index == (adjectives.length - 1);

}
