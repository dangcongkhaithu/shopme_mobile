import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/pages/home/widgets/category_widget.dart';
import 'package:shopme_mobile/pages/home/widgets/header_widget.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    final double marginTop = MediaQuery.of(context).size.height * 0.15;
    return Stack(
      //fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: marginTop,
          color: Colors.black,
        ),
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: marginTop)),
            _buildHeader(),
            SliverToBoxAdapter(child: const SizedBox(height: 10)),
            _buildCategory(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: _buildSearchField(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: HeaderWidget(),
    );
  }

  Widget _buildCategory() {
    return SliverToBoxAdapter(
      child: CategoryWidget(),
    );
  }

  Widget _buildSearchField() {
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
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
