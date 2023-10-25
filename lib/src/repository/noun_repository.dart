import 'package:flutter/material.dart';

import '../model/sentence/adjective/adjective.dart';
import '../model/sentence/noun/any_noun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/noun/pronoun.dart';
import '../model/sentence/phrase/determiner.dart';
import '../util/util.dart';

class NounRepository extends ChangeNotifier {
  List<Pronoun> subjectPronouns() => const [
        Pronoun('I', 'yo', PersonalPronoun.I),
        Pronoun('you', 'tu/ustedes', PersonalPronoun.you),
        Pronoun('he', 'él', PersonalPronoun.he),
        Pronoun('she', 'ella', PersonalPronoun.she),
        Pronoun('it', 'eso', PersonalPronoun.it),
        Pronoun('we', 'nosotros', PersonalPronoun.we),
        Pronoun('they', 'ellos', PersonalPronoun.they)
      ];

  List<Pronoun> objectPronouns() => const [
        Pronoun('me', 'me', PersonalPronoun.I),
        Pronoun('you', 'te', PersonalPronoun.you),
        Pronoun('him', 'lo/le', PersonalPronoun.he),
        Pronoun('her', 'lo/le', PersonalPronoun.she),
        Pronoun('it', 'lo/le', PersonalPronoun.it),
        Pronoun('us', 'nos', PersonalPronoun.we),
        Pronoun('them', 'les', PersonalPronoun.they)
      ];

  List<Pronoun> possessivePronouns() => const [
        Pronoun('mine', 'mio(a)/el mio/la mia/los míos/las mías',
            PersonalPronoun.I),
        Pronoun(
            'yours',
            'tuyo/el tuyo/la tuya/los tuyos(as)/suyo/el suyo/la suya/las suyas',
            PersonalPronoun.you),
        Pronoun('his', 'suyo/el suyo/la suya/los suyos/las suyas',
            PersonalPronoun.he),
        Pronoun('hers', 'suyo/el suyo/la suya/los suyos/las suyas',
            PersonalPronoun.she),
        Pronoun('its', 'suyo/el suyo/la suya/los suyos/las suyas',
            PersonalPronoun.it),
        Pronoun(
            'ours',
            'nuestro/el nuestro/la nuestra/los nuestros/las nuestras',
            PersonalPronoun.we),
        Pronoun('theirs', 'suyo/el suyo/la suya/los suyos/las suyas',
            PersonalPronoun.they)
      ];

  List<Noun> nouns(Determiner? determiner) {
    List<Noun> nouns = const [
      Noun('pet', 'mascota', Countability.singular),
      Noun('pets', 'mascotas', Countability.plural),
      Noun('water', 'agua', Countability.uncountable),
    ];
    if (determiner == null) {
      return nouns;
    }
    return nouns.where((e) {
      return e.isUncountable && determiner.allowsUncountable ||
          e.isSingular && determiner.allowsSingular ||
          e.isPlural && determiner.allowsPlural;
    }).toList();
  }

  List<Determiner> articles(Noun? noun) {
    List<Determiner> articles = [
      Determiner.article('a', 'un/una', false, true, false),
      Determiner.article('an', 'un/una', false, true, false),
      Determiner.article('the', 'el/la/los/las', true, true, true),
    ];
    if (noun == null) {
      return articles;
    }
    bool nounStartsWithVowel = Util.isVowel(noun.en.substring(0, 1));
    if (noun.isSingular && nounStartsWithVowel) {
      return [articles[1], articles.last];
    } else if (noun.isSingular && !nounStartsWithVowel) {
      return [articles.first, articles.last];
    }
    return [articles.last];
  }

  List<Determiner> possessives() {
    return [
      Determiner.possessive('my', 'mi/mis'),
      Determiner.possessive('your', 'tu/tus/su/sus'),
      Determiner.possessive('his', 'su/sus'),
      Determiner.possessive('her', 'su/sus'),
      Determiner.possessive('its', 'su/sus'),
      Determiner.possessive('our', 'nuestro/nuestros'),
      Determiner.possessive('their', 'su/sus'),
    ];
  }

  List<Determiner> demonstrativeAdjectives(Noun? noun) {
    List<Determiner> demonstrativeAdjectives = [
      Determiner.demonstrative('this', 'este/esta', true, true, false),
      Determiner.demonstrative('that', 'ese/esa', true, true, false),
      Determiner.demonstrative('these', 'estos/estas', false, false, true),
      Determiner.demonstrative('those', 'esos/esas', false, false, true),
    ];
    if (noun == null) {
      return demonstrativeAdjectives;
    }
    return demonstrativeAdjectives
        .where((e) =>
            noun.isUncountable && e.allowsUncountable ||
            noun.isSingular && e.allowsSingular ||
            noun.isPlural && e.allowsPlural)
        .toList();
  }

  List<Determiner> distributiveAdjectives(Noun? noun) {
    List<Determiner> distributiveAdjectives = [
      Determiner.distributive('each', 'cada', false, true, false),
      Determiner.distributive('every', 'todos', false, true, false),
      Determiner.distributive('either', 'cualquiera', false, true, true),
      Determiner.distributive('neither', 'ni', false, true, true),
      Determiner.distributive('any', 'cualquier/cualquiera', true, true, true),
      Determiner.distributive('both', 'ambos', false, false, true),
    ];
    if (noun == null) {
      return distributiveAdjectives;
    }
    return distributiveAdjectives
        .where((e) =>
            noun.isUncountable && e.allowsUncountable ||
            noun.isSingular && e.allowsSingular ||
            noun.isPlural && e.allowsPlural)
        .toList();
  }

  List<Determiner> quantifiers(Noun? noun) {
    List<Determiner> quantifiers = [
      Determiner.quantifier(
          'some', 'algún/alguna/algunos/algunas', true, true, true),
      Determiner.quantifier('many', 'varios/varias', false, false, true),
      Determiner.quantifier('a few', 'algunos/algunas', false, false, true),
      Determiner.quantifier(
          'the few', 'los pocos/las pocas', false, false, true),
      Determiner.quantifier(
          'a lot of', 'mucho/mucha/muchos', true, false, true),
      Determiner.quantifier('several', 'varios', false, false, true),
    ];
    if (noun == null) {
      return quantifiers;
    }
    return quantifiers
        .where((e) =>
            noun.isUncountable && e.allowsUncountable ||
            noun.isSingular && e.allowsSingular ||
            noun.isPlural && e.allowsPlural)
        .toList();
  }

  List<Determiner> numbers(Noun? noun, [bool includeOrdinalNumbers = false]) {
    List<Determiner> ordinalNumbers = [
      Determiner.ordinalNumber('first', 'primer/primero(a)'),
      Determiner.ordinalNumber('second', 'segundo(a)'),
      Determiner.ordinalNumber('third', 'tercero(a)'),
      Determiner.ordinalNumber('fourth', 'cuarto(a)'),
      Determiner.ordinalNumber('fifth', 'quinto(a)'),
      Determiner.ordinalNumber('sixth', 'sexto(a)'),
      Determiner.ordinalNumber('seventh', 'séptimo(a)'),
      Determiner.ordinalNumber('eighth', 'octavo(a)'),
      Determiner.ordinalNumber('ninth', 'noveno(a)'),
      Determiner.ordinalNumber('tenth', 'décimo(a)'),
      Determiner.ordinalNumber('eleventh', 'onceavo(a)'),
      Determiner.ordinalNumber('twelfth', 'doceavo(a)'),
      Determiner.ordinalNumber('thirteenth', 'treceavo(a)'),
      Determiner.ordinalNumber('fourteenth', 'décimo cuarto(a)'),
      Determiner.ordinalNumber('fifteenth', 'décimo quinto(a)'),
      Determiner.ordinalNumber('sixteenth', 'décimo sexto(a)'),
      Determiner.ordinalNumber('seventeenth', 'décimo séptimo(a)'),
      Determiner.ordinalNumber('eighteenth', 'décimo octavo(a)'),
      Determiner.ordinalNumber('nineteenth', 'décimo noveno(a)'),
      Determiner.ordinalNumber('twentieth', 'vigésimo(a)'),
    ];
    List<Determiner> naturalNumbers = [
      Determiner.one(),
      Determiner.naturalNumber('two', 'dos'),
      Determiner.naturalNumber('three', 'tres'),
      Determiner.naturalNumber('four', 'cuatro'),
      Determiner.naturalNumber('five', 'cinco'),
      Determiner.naturalNumber('six', 'seis'),
      Determiner.naturalNumber('seven', 'siete'),
      Determiner.naturalNumber('eight', 'ocho'),
      Determiner.naturalNumber('nine', 'nueve'),
      Determiner.naturalNumber('ten', 'diez'),
      Determiner.naturalNumber('eleven', 'once'),
      Determiner.naturalNumber('twelve', 'doce'),
      Determiner.naturalNumber('thirteen', 'trece'),
      Determiner.naturalNumber('fourteen', 'catorce'),
      Determiner.naturalNumber('fifteen', 'quince'),
      Determiner.naturalNumber('sixteen', 'dieciséis'),
      Determiner.naturalNumber('seventeen', 'diecisiete'),
      Determiner.naturalNumber('eighteen', 'dieciocho'),
      Determiner.naturalNumber('nineteen', 'diecinueve'),
      Determiner.naturalNumber('twenty', 'veinte'),
    ];
    if (noun == null) {
      return [
        ...naturalNumbers,
        if (includeOrdinalNumbers) ...ordinalNumbers,
      ];
    }
    return [
      ...naturalNumbers
          .where((e) =>
              noun.isUncountable && e.allowsUncountable ||
              noun.isSingular && e.allowsSingular ||
              noun.isPlural && e.allowsPlural)
          .toList(),
      if (includeOrdinalNumbers && !noun.isPlural) ...ordinalNumbers,
    ];
  }

  List<Adjective> adjectives() => const [
        Adjective('beautiful', 'hermoso(a)', 'hermosos(as)'),
        Adjective('small', 'pequeño(a)', 'pequeños(as)'),
        Adjective('big', 'grande', 'grandes'),
        Adjective('intelligent', 'inteligente', 'inteligente'),
        Adjective('round', 'redondo(a)', 'redondos(as)'),
        Adjective('lazy', 'perezoso(a)', 'perezosos(as)'),
        Adjective('old', 'viejo(a)', 'viejos(as)')
      ];
}
