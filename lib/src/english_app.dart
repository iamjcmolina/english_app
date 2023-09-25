import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'service/vocabulary_service.dart';
import 'service/sentence_cubit.dart';
import 'widget/sentence/clause/independent_clause_page.dart';

class EnglishApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  static final List<Widget> globalActions = [
    IconButton(
      icon: Icon(EnglishApp.themeNotifier.value == ThemeMode.light
          ? Icons.dark_mode
          : Icons.light_mode),
      onPressed: () {
        EnglishApp.themeNotifier.value =
        EnglishApp.themeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
      }
    ),
  ];

  const EnglishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SentenceCubit()),
        ],
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (BuildContext context) => VocabularyService()),
            ],
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (_, ThemeMode currentMode, __) {
                return MaterialApp(
                  title: 'English Grammar App',
                  home: const IndependentClausePage(),
                  theme: ThemeData.light(useMaterial3: true),
                  darkTheme: ThemeData.dark(useMaterial3: true),
                  themeMode: currentMode,
                  debugShowCheckedModeBanner: false,
                );
              })
        )
    );
  }
}
