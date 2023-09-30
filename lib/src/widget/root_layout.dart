import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../english_app.dart';

class RootLayout extends StatefulWidget {
  final String title;
  final List<Widget> bottomAppBarChildren;
  final bool showBottomAppBar;
  final Widget header;
  final Widget body;

  const RootLayout({
    super.key,
    required this.title,
    this.bottomAppBarChildren = const[],
    this.showBottomAppBar = false,
    required this.header,
    required this.body,
  });

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  late ScrollController _controller;
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: EnglishApp.globalActions,
      ),
      body: Column(
        children: [
          widget.header,
          Expanded(
            child: ListView(
              controller: _controller,
              children: [
                widget.body,
                const SizedBox(height: 25),
              ],
            )
          ),
        ],
      ),
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
    final ScrollDirection direction = _controller.position.userScrollDirection;
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
    _controller = ScrollController();
    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }
}
