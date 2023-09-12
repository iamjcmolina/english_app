import 'package:bloc/bloc.dart';

import '../model/nullable.dart';
import '../model/sentence/clause/independent_clause.dart';
import '../model/sentence/clause/independent_clause_settings.dart';
import '../model/sentence/clause/value/clause_type.dart';
import '../model/sentence/clause/value/tense.dart';
import '../model/sentence/noun/subject.dart';
import '../model/sentence/noun/value/subject_type.dart';
import '../model/sentence/sentence.dart';
import '../model/sentence/verb/any_verb.dart';

class SentenceCubit extends Cubit<Sentence> {
  SentenceCubit() : super(
      Sentence(independentClause: IndependentClause())
  );
}