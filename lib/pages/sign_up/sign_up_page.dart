import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:shopme_mobile/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/sign_in/sign_in_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpPageState();

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => SignUpPage(),
    );
  }
}

class SignUpPageState extends State<SignUpPage> {
  late ScrollController _scrollController;
  late SignUpBloc _signUpBloc;
  String email = "";
  String password = "";
  String confirmPassword = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _signUpBloc = getIt<SignUpBloc>();

    _signUpBloc.stream.listen((event) {
      if (event is SignUpSuccessState) {
        Navigator.of(context).push(SignInPage.getRoute(email: email, password: password));
      } else if (event is ErrorState) {
        Fluttertoast.showToast(msg: TranslateHelper.somethingWentWrong);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _signUpBloc.close();
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
          TranslateHelper.signUp,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: _buildSignUp(),
    );
  }

  Widget _buildSignUp() {
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
              const SizedBox(height: 50),
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
                    "Have an account ?",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.mainColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(SignInPage.getRoute());
                    },
                    child: Text(
                      "Sign In",
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
        _buildFormItem("Email", "Enter valid mail id as abc@gmail.com", (value) => email = value),
        _buildFormItem("Password", "Enter your password", (value) => password = value, obscureText: true),
        _buildFormItem("Confirm Password", "Confirm your password", (value) => confirmPassword = value,
            obscureText: true),
      ],
    );
  }

  Widget _buildFormItem(String label, String hint, Function(String value) onSubmitValue, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        onTap: () => _scrollToTop(),
        onChanged: (value) => onSubmitValue(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 300,
      child: TextButton(
        onPressed: () {
          RequestSignUp request = RequestSignUp(
            email: email,
            password: password,
          );
          _signUpBloc.signUp(request);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          TranslateHelper.signUp,
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
