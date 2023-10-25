import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'repository/adverb_repository.dart';
import 'repository/noun_repository.dart';
import 'repository/verb_repository.dart';
import 'service/independent_clause_cubit.dart';
import 'service/independent_clause_service.dart';
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
        }),
  ];

  const EnglishApp({super.key});

  @override
  Widget build(BuildContext context) {
    final adverbRepository = AdverbRepository();
    final nounRepository = NounRepository();
    final verbRepository = VerbRepository();
    final clauseService = IndependentClauseService();
    final clauseCubit = IndependentClauseCubit(clauseService);

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => clauseCubit),
        ],
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => adverbRepository),
              ChangeNotifierProvider(create: (_) => nounRepository),
              ChangeNotifierProvider(create: (_) => verbRepository),
              ChangeNotifierProvider(create: (_) => clauseService),
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
                })));
  }
}
