import 'package:flutter/material.dart';

class SentenceScaffold extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  static final List<Widget> globalActions = [
    IconButton(
        icon: Icon(themeNotifier.value == ThemeMode.light
            ? Icons.dark_mode
            : Icons.light_mode),
        onPressed: () {
          themeNotifier.value = themeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light;
        }),
  ];

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
        actions: globalActions,
      ),
      body: body,
      bottomNavigationBar: bottomActions.isEmpty
          ? null
          : BottomAppBar(
              child: Row(
                children: bottomActions,
              ),
            ),
    );
  }
}
