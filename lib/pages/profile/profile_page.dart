import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_bloc.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/profile/widgets/text_custom.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/common/edit_profile_dialog.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => ProfilePage(),
    );
  }
}

class ProfilePageState extends State<ProfilePage> {
  late GetUserProfileBloc _getUserProfileBloc;
  late SharedPref _sharedPref;

  @override
  void initState() {
    super.initState();
    _getUserProfileBloc = getIt<GetUserProfileBloc>();
    _sharedPref = getIt<SharedPref>();
  }

  @override
  void dispose() {
    _getUserProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getUserProfileBloc.getUserProfile(_sharedPref.token);
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
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: BlocBuilder(
        bloc: _getUserProfileBloc,
        builder: (_, state) {
          if (state is GetUserProfileSuccessState) {
            UserProfile userProfile = state.userProfile;
            return _buildBody(userProfile);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(UserProfile userProfile) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _buildAvatar(),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                text: "Full name: ",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 10),
              Expanded(child: TextCustom(text: userProfile.firstname + " " + userProfile.lastname)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: "Email: ", fontWeight: FontWeight.bold),
              const SizedBox(width: 10),
              Expanded(child: TextCustom(text: userProfile.user.email)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: "Phone: ", fontWeight: FontWeight.bold),
              const SizedBox(width: 10),
              Expanded(child: TextCustom(text: userProfile.phone)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: "Address: ", fontWeight: FontWeight.bold),
              const SizedBox(width: 10),
              Expanded(child: TextCustom(text: userProfile.address)),
            ],
          ),
          const SizedBox(height: 50),
          _buildButtonEdit(userProfile),
        ],
      ),
    );
  }

  Widget _buildButtonEdit(UserProfile userProfile) {
    return SizedBox(
      width: 150,
      height: 40,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => EditProfileDialog(
              userProfile: userProfile,
            ),
          ).then((_) {
            setState(() {});
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: CircularButton(
          icon: const Icon(
            Icons.person_sharp,
            color: AppColors.white,
            size: 60,
          ),
          onPressed: () {
            print("Navigate");
          },
        ),
      ),
    );
  }
}
