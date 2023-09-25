import 'package:bloc/bloc.dart';

import '../model/sentence/clause/independent_clause.dart';
import '../model/sentence/sentence.dart';

class SentenceCubit extends Cubit<Sentence> {
  SentenceCubit() : super(
      Sentence(independentClause: IndependentClause())
  );
}