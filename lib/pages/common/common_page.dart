import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/pages/account/account_page.dart';
import 'package:shopme_mobile/pages/home/home_page.dart';
import 'package:shopme_mobile/pages/search/search_page.dart';

class CommonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommonPageState();
}

class CommonPageState extends State<CommonPage> {
  late ValueNotifier<int> _selectedIndexNotifier;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _selectedIndexNotifier = ValueNotifier(0);
    _pages = [HomePage(), SearchPage(), AccountPage()];
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
      selectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
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
