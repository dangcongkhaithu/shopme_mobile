import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignInPageState();

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => SignInPage(),
    );
  }
}

class SignInPageState extends State<SignInPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CircularButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TranslateHelper.signIn,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: _buildSignIn(),
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildAppIcon(),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 30),
              _buildSubmitButton(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User?",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.mainColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            onTap: () => _scrollToTop(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              labelText: 'User Name',
              hintText: 'Enter valid mail id as abc@gmail.com',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            onTap: () => _scrollToTop(),
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              labelText: 'Password',
              hintText: 'Enter your secure password',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 300,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          TranslateHelper.signIn,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildAppIcon() {
    return Container(
      width: 80,
      height: 80,
      child: FlutterLogo(),
    );
  }

  void _scrollToTop() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
