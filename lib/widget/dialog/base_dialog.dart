import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class BaseDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const BaseDialog({
    Key? key,
    this.title = "",
    required this.content,
    this.actions = const [],
  }) : super(key: key);

  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: _buildTitle(),
      content: _buildContent(),
    );
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.actions,
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            widget.content,
            if (widget.actions.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildActions(),
            ],
          ],
        ),
      ),
    );
  }
}