import 'package:flutter/material.dart';

import '../english_app.dart';

class SentenceScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> bottomActions;

  const SentenceScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomActions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: EnglishApp.globalActions,
      ),
      body: body,
      bottomNavigationBar: bottomActions.isEmpty? null :
      BottomAppBar(
        child: Row(
          children: bottomActions,
        ),
      ),
    );
  }
}
