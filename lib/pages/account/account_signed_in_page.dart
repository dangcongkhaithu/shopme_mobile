import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_bloc.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_state.dart';
import 'package:shopme_mobile/blocs/update_user_profile_bloc/update_user_profile_bloc.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/cart/cart_page.dart';
import 'package:shopme_mobile/pages/profile/widgets/text_custom.dart';
import 'package:shopme_mobile/pages/common/common_page.dart';
import 'package:shopme_mobile/pages/sign_in/sign_in_page.dart';
import 'package:shopme_mobile/pages/sign_up/sign_up_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class AccountSignedInPage extends StatefulWidget {
  final String token;

  const AccountSignedInPage({Key? key, required this.token}) : super();

  @override
  State<StatefulWidget> createState() => AccountSignedInPageState();

  static MaterialPageRoute getRoute({required String token}) {
    return MaterialPageRoute(
      builder: (context) => AccountSignedInPage(token: token),
    );
  }
}

class AccountSignedInPageState extends State<AccountSignedInPage> {
  late GetUserProfileBloc _getUserProfileBloc;
  late SharedPref _sharedPref;
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
    _getUserProfileBloc = getIt<GetUserProfileBloc>();
    _sharedPref = getIt<SharedPref>();
    _getUserProfileBloc.getUserProfile(widget.token);

    _getUserProfileBloc.stream.listen((event) {
      if(event is GetUserProfileSuccessState) {
        _userProfile = event.userProfile;
      }
    });
  }

  @override
  void dispose() {
    _getUserProfileBloc.close();
    super.dispose();
  }

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
      child: Column(
        children: [
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text(widget.token),
    );
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
                if(_sharedPref.token == "") {
                  Navigator.of(context).push(SignInPage.getRoute());
                } else {
                  Navigator.of(context).push(CartPage.getRoute());
                }
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
                _sharedPref.storeToken("");
                Navigator.of(context).push(CommonPage.getRoute(selectedPage: 2));
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(),
            const SizedBox(width: 30),
            _buildNameUser(),
            const SizedBox(width: 30),
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

  Widget _buildNameUser() {
    _getUserProfileBloc.getUserProfile(widget.token);
    return BlocBuilder(
      bloc: _getUserProfileBloc,
      builder: (context, state) {
        if (state is GetUserProfileSuccessState) {
          UserProfile userProfile = state.userProfile;
          return Expanded(
            child: Text(
              userProfile.user.email,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
