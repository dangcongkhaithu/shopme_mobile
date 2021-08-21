import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/pages/profile/widgets/text_custom.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class ProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const ProfilePage({Key? key, required this.userProfile}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();

  static MaterialPageRoute getRoute({required UserProfile userProfile}) {
    return MaterialPageRoute(
      builder: (context) => ProfilePage(userProfile: userProfile),
    );
  }
}

class ProfilePageState extends State<ProfilePage> {
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = widget.userProfile;
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
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
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
        )
      ],
    );
  }
}
