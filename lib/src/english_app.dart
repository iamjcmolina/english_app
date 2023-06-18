import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/sentence_cubit.dart';
import 'widget/page/sentence_page.dart';
import 'service/vocabulary_service.dart';

class EnglishApp extends StatelessWidget {
  const EnglishApp({super.key});

  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //    SystemUiOverlay.top
    //  ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SentenceCubit()),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (BuildContext context) => VocabularyService()),
          ],
          child: MaterialApp(
            title: 'English Grammar App',
            initialRoute: 'sentencePage',
            routes: {
              'sentencePage': (BuildContext context) => SentencePage(),
            },
            theme: ThemeData.light(useMaterial3: true),
          ),
        )
    );
  }
}
