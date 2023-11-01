import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/repository/vocabulary_provider.dart';
import 'src/repository/vocabulary_repository.dart';
import 'src/service/independent_clause_cubit.dart';
import 'src/widget/common/sentence_scaffold.dart';
import 'src/widget/page/independent_clause_page.dart';

void main() {
  runApp(const EnglishApp());
}

class EnglishApp extends StatelessWidget {
  const EnglishApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vocabularyProvider = VocabularyProvider(context);
    final vocabularyRepository = VocabularyRepository(vocabularyProvider);
    final clauseCubit = IndependentClauseCubit();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => clauseCubit),
        ],
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => vocabularyProvider),
              ChangeNotifierProvider(create: (_) => vocabularyRepository),
            ],
            child: ValueListenableBuilder<ThemeMode>(
                valueListenable: SentenceScaffold.themeNotifier,
                builder: (_, ThemeMode currentMode, __) {
                  return MaterialApp(
                    title: 'English Grammar App',
                    home: const IndependentClausePage(),
                    theme: ThemeData.light(useMaterial3: true),
                    darkTheme: ThemeData.dark(useMaterial3: true),
                    themeMode: currentMode,
                    debugShowCheckedModeBanner: false,
                  );
                })));
  }
}
