import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/blocs/update_user_profile_bloc/update_user_profile_bloc.dart';
import 'package:shopme_mobile/blocs/update_user_profile_bloc/update_user_profile_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/data/schemas/request/remote/update_user_profile/request_update_user_profile.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/common/common_page.dart';
import 'package:shopme_mobile/pages/profile/profile_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class EditProfileDialog extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileDialog({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditProfileDialogState();
}

class EditProfileDialogState extends State<EditProfileDialog> {
  late UpdateUserProfileBloc _updateUserProfileBloc;
  late SharedPref _sharedPref;
  String firstname = "";
  String lastname = "";
  String phone = "";
  String address = "";

  @override
  void initState() {
    super.initState();
    _updateUserProfileBloc = getIt<UpdateUserProfileBloc>();
    _sharedPref = getIt<SharedPref>();
    firstname = widget.userProfile.firstname;
    lastname = widget.userProfile.lastname;
    phone = widget.userProfile.phone;
    address = widget.userProfile.address;

    _updateUserProfileBloc.stream.listen((event) {
      if (event is UpdateUserProfileSuccessState) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _updateUserProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Column(
          children: [
            _buildFormItem(
              "Fist name: ",
              "Enter new fist name",
              widget.userProfile.firstname,
              (value) => firstname = value,
            ),
            _buildFormItem(
              "Last name: ",
              "Enter new last name",
              widget.userProfile.lastname,
              (value) => lastname = value,
            ),
            _buildFormItem(
              "Phone: ",
              "Enter your new phone",
              widget.userProfile.phone,
              (value) => phone = value,
            ),
            _buildFormItem(
              "Address: ",
              "Enter new address",
              widget.userProfile.address,
              (value) => address = value,
            ),
            const SizedBox(height: 20),
            _buildButtonSave(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSave() {
    return SizedBox(
      width: 150,
      height: 40,
      child: TextButton(
        onPressed: () {
          RequestUpdateUserProfile request = RequestUpdateUserProfile(
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            address: address,
          );
          _updateUserProfileBloc.updateUserProfile(_sharedPref.token, request);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          "Save Profile",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFormItem(String label, String hint, String defaultText, Function(String value) onSubmitValue,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: TextEditingController()..text = defaultText,
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
}
