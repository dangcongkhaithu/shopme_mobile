import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final Color color;

  const BasePage({
    Key? key,
    required this.child,
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.color = AppColors.white,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}


class _BasePageState extends State<BasePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: widget.appBar,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: widget.child,
    );
  }
}
