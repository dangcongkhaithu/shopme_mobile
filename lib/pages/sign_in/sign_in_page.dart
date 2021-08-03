import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:shopme_mobile/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/account/account_signed_in_page.dart';
import 'package:shopme_mobile/pages/common/common_page.dart';
import 'package:shopme_mobile/pages/sign_up/sign_up_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class SignInPage extends StatefulWidget {
  final String email;
  final String password;

  const SignInPage({
    Key? key,
    this.email = "",
    this.password = "",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignInPageState();

  static MaterialPageRoute getRoute({String email = "", String password = ""}) {
    return MaterialPageRoute(
      builder: (context) => SignInPage(
        email: email,
        password: password,
      ),
    );
  }
}

class SignInPageState extends State<SignInPage> {
  late ScrollController _scrollController;
  late SignInBloc _signInBloc;
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _signInBloc = getIt<SignInBloc>();
    email = widget.email;
    password = widget.password;

    _signInBloc.stream.listen((event) {
      if (event is SignInSuccessState) {
        Navigator.of(context).push(CommonPage.getRoute(selectedPage: 2));
      } else if (event is ErrorState) {
        Fluttertoast.showToast(msg: TranslateHelper.somethingWentWrong);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _signInBloc.close();
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
                    onPressed: () {
                      Navigator.of(context).push(SignUpPage.getRoute());
                    },
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
            controller: TextEditingController()..text = widget.email,
            onTap: () => _scrollToTop(),
            onChanged: (value) => email = value,
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
            controller: TextEditingController()..text = widget.password,
            onTap: () => _scrollToTop(),
            onChanged: (value) => password = value,
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
        onPressed: () {
          RequestSignIn request = RequestSignIn(email: email, password: password);
          _signInBloc.signIn(request);
        },
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
