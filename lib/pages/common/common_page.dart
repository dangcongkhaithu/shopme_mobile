import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/account/account_page.dart';
import 'package:shopme_mobile/pages/account/account_page_signed_out_page.dart';
import 'package:shopme_mobile/pages/account/account_signed_in_page.dart';
import 'package:shopme_mobile/pages/category/category_page.dart';
import 'package:shopme_mobile/pages/home/home_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class CommonPage extends StatefulWidget {
  final int selectedPage;
  final int selectedCategoryPage;

  const CommonPage({
    Key? key,
    this.selectedPage = 0,
    this.selectedCategoryPage = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommonPageState();

  static MaterialPageRoute getRoute({int selectedPage = 0, int selectedCategoryPage = 0}) {
    return MaterialPageRoute(
      builder: (context) => CommonPage(
        selectedPage: selectedPage,
        selectedCategoryPage: selectedCategoryPage,
      ),
    );
  }
}

class CommonPageState extends State<CommonPage> {
  late ValueNotifier<int> _selectedIndexNotifier;
  List<Widget> _pages = [];
  late SharedPref _sharedPref;

  @override
  void initState() {
    super.initState();
    _selectedIndexNotifier = ValueNotifier(widget.selectedPage);
    _sharedPref = getIt<SharedPref>();

    _pages = [HomePage(), CategoryPage(selectedCategoryIndex: widget.selectedCategoryPage)];

    print(_sharedPref.token);

    if (_sharedPref.token != "") {
      _pages.add(AccountSignedInPage(token: _sharedPref.token));
    } else {
      _pages.add(AccountPageSignedOutPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (_, selectedIndex, __) => Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(selectedIndex),
        body: Center(
          child: _pages.elementAt(selectedIndex),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      backgroundColor: AppColors.mainColor,
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: "Category",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Account",
        )
      ],
      currentIndex: selectedIndex,
      onTap: (index) => _selectedIndexNotifier.value = index,
    );
  }
}
