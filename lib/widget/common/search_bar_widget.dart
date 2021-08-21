import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_bloc.dart';
import 'package:shopme_mobile/blocs/recent_search_bloc/recent_search_bloc.dart';
import 'package:shopme_mobile/blocs/recent_search_bloc/recent_search_state.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/local/models/recent_search.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/cart/cart_page.dart';
import 'package:shopme_mobile/pages/search/search_page.dart';
import 'package:shopme_mobile/pages/sign_in/sign_in_page.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late RecentSearchBloc _recentSearchBloc;
  late ValueNotifier<List<RecentSearch>> _recentSearchNotifier;
  late SharedPref _sharedPref;

  @override
  void initState() {
    _recentSearchBloc = getIt<RecentSearchBloc>();
    _sharedPref = getIt<SharedPref>();
    _recentSearchNotifier = ValueNotifier([]);

    _recentSearchBloc.getAll();

    _recentSearchBloc.stream.listen((event) {
      if (event is GetRecentSearchSuccessState) {
        _recentSearchNotifier.value = event.listRecentSearch;
      } else if (event is FilterRecentSearchSuccessState) {
        _recentSearchNotifier.value = event.listRecentSearch;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _recentSearchBloc.close();
    _recentSearchNotifier.dispose();
    super.dispose();
  }

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
        _recentSearchBloc.filter(query);
      },
      onSubmitted: (query) {
        _recentSearchBloc.saveOne(query);
        Navigator.of(context).push(SearchPage.getRoute(keyWord: query)).then((_) {
          setState(() {});
        });
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
              if (_sharedPref.token == "") {
                Navigator.of(context).push(SignInPage.getRoute());
              } else {
                Navigator.of(context).push(CartPage.getRoute());
              }
            },
          ),
        ),
      ],
      builder: (context, _) {
        return ValueListenableBuilder<List<RecentSearch>>(
          valueListenable: _recentSearchNotifier,
          builder: (_, recentSearch, __) {
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
      },
    );
  }

  Widget _buildRecentSearchItem(RecentSearch item) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(SearchPage.getRoute(keyWord: item.content)).then((_) {
          setState(() {});
        });
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item.content,
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
              onPressed: () {
                _recentSearchBloc.deleteOne(item.id);
                _recentSearchBloc.getAll();
              },
            ),
          ],
        ),
      ),
    );
  }
}
