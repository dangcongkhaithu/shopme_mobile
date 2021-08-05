import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final Widget? endDrawer;
  final BasePageController? controller;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final Color color;

  const BasePage({
    Key? key,
    required this.child,
    this.endDrawer,
    this.controller,
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.color = AppColors.white,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class BasePageController {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  BasePageController() : _scaffoldKey = GlobalKey();

  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    ScaffoldState? scaffoldState = _scaffoldKey.currentState;
    if (scaffoldState != null) {
      if (scaffoldState.isEndDrawerOpen) {
        Navigator.of(scaffoldState.context).pop();
      }
    }
  }
}

class _BasePageState extends State<BasePage> {
  late BasePageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? BasePageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: widget.appBar,
      key: _controller._scaffoldKey,
      endDrawer: widget.endDrawer,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: widget.child,
    );
  }
}
