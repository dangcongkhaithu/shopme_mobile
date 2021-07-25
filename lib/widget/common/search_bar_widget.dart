import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  final List<String> recentSearch = ["xiaomi redmi 4x", "Iphone", "Laptop dell", "Macbook pro"];

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: TranslateHelper.search,
      hintStyle: TextStyle(
        fontStyle: FontStyle.italic,
      ),
      transitionCurve: Curves.easeInOutCubic,
      transition: CircularFloatingSearchBarTransition(),
      physics: const BouncingScrollPhysics(),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              print("Navigate To Cart");
            },
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: recentSearch.map((e) {
                return _buildRecentSearchItem(e);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentSearchItem(String item) {
    return TextButton(
      onPressed: () {},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            CircularButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
