import 'package:flutter/material.dart';

import '../english_app.dart';

class RootLayout extends StatelessWidget {
  final String title;
  final List<Widget> bottomAppBarChildren;
  final bool showBottomAppBar;
  final Widget child;

  const RootLayout({
    super.key,
    required this.title,
    this.bottomAppBarChildren = const[],
    this.showBottomAppBar = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: EnglishApp.globalActions,
      ),
      body: child,
      bottomNavigationBar: bottomAppBarChildren.isEmpty? null : AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: showBottomAppBar ? 80.0 : 0,
        child: BottomAppBar(
          elevation: null,
          child: Row(
            children: bottomAppBarChildren,
          ),
        ),
      ),
    );
  }
}
