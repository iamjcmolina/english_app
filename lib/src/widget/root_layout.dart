import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../english_app.dart';

class RootLayout extends StatefulWidget {
  final String title;
  final List<Widget> bottomAppBarChildren;
  final bool showBottomAppBar;
  final Widget child;
  final ScrollController controller;

  const RootLayout({
    super.key,
    required this.title,
    this.bottomAppBarChildren = const[],
    this.showBottomAppBar = false,
    required this.child,
    required this.controller,
  });

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: EnglishApp.globalActions,
      ),
      body: widget.child,
      bottomNavigationBar: widget.bottomAppBarChildren.isEmpty? null : AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isVisible ? 80.0 : 0,
        child: BottomAppBar(
          elevation: null,
          child: Row(
            children: widget.bottomAppBarChildren,
          ),
        ),
      ),
    );
  }

  void _listen() {
    final ScrollDirection direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _show();
    } else if (direction == ScrollDirection.reverse) {
      _hide();
    }
  }

  void _show() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  void initState() {
    super.initState();
    //_controller = ScrollController();
    widget.controller.addListener(_listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listen);
    widget.controller.dispose();
    super.dispose();
  }
}
