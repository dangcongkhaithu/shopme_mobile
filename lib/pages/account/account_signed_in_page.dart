import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/data/remote/models/remote/user/user.dart';

class AccountSignedInPage extends StatefulWidget {
  final User user;

  const AccountSignedInPage({Key? key, required this.user}) : super();

  @override
  State<StatefulWidget> createState() => AccountSignedInPageState();

  static MaterialPageRoute getRoute({required User user}) {
    return MaterialPageRoute(
      builder: (context) => AccountSignedInPage(user: user),
    );
  }
}

class AccountSignedInPageState extends State<AccountSignedInPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.user.fullName),
    );
  }
}
