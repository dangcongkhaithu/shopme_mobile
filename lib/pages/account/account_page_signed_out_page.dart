import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/pages/sign_in/sign_in_page.dart';
import 'package:shopme_mobile/pages/sign_up/sign_up_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class AccountPageSignedOutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountPageSignedOutPageState();
}

class AccountPageSignedOutPageState extends State<AccountPageSignedOutPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: Container(
          color: AppColors.mainColor,
          child: _buildAppBar(),
        ),
      ),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox.shrink();
  }

  Widget _buildAppBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircularButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                print("Navigate To Cart");
              },
            ),
            const SizedBox(width: 10),
            CircularButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                print("Navigate To Setting");
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildAvatar(),
            Row(
              children: [
                _buildSignInButton(),
                const SizedBox(width: 10),
                _buildSignUpButton(),
                const SizedBox(width: 20)
              ],
            )
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircularButton(
          icon: const Icon(
            Icons.person_sharp,
            color: AppColors.mainColor,
            size: 40,
          ),
          onPressed: () {
            print("Navigate");
          },
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: 100,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(SignInPage.getRoute());
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        child: Text(
          TranslateHelper.signIn,
          style: TextStyle(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: 80,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(SignUpPage.getRoute());
        },
        style: TextButton.styleFrom(
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Text(
          TranslateHelper.signUp,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
