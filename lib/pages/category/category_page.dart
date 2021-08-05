import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/common/search_bar_widget.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  late CategoryBloc _getCategoriesBloc;
  late ValueNotifier<int> _selectedNotifier;
  late PageController _pageController;
  int countCategories = 0;

  @override
  void initState() {
    super.initState();
    _getCategoriesBloc = getIt<CategoryBloc>();
    _getCategoriesBloc.getAllCategories();

    _selectedNotifier = ValueNotifier(0);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _getCategoriesBloc.close();
    _selectedNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      color: AppColors.background,
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    final double marginTop = 150;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            _buildBody(),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: marginTop,
          color: AppColors.mainColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SearchBarWidget(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Row(
        children: [
          _buildParent(),
          _buildChild(),
        ],
      ),
    );
  }

  Widget _buildParent() {
    return SizedBox(
        width: 120,
        child: BlocBuilder(
          bloc: _getCategoriesBloc,
          builder: (_, state) {
            if (state is GetCategorySuccessState) {
              List<Category> categories = [];
              state.categories.forEach((element) {
                if (element.hasChildren) {
                  categories.add(element);
                }
              });
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  return _buildParentItem(index, categories);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _buildParentItem(int index, List<Category> categories) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedNotifier,
      builder: (_, selectedIndex, __) {
        if (selectedIndex == index) {
          return Container(
            width: 120,
            height: 150,
            color: AppColors.background,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 50,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      Text(categories[index].name)
                    ],
                  ),
                ),
                Container(
                  width: 10,
                  height: 150,
                  color: Colors.blue,
                ),
              ],
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              _selectedNotifier.value = index;
              _pageController.jumpToPage(index);
            },
            child: Container(
              width: 120,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: AppColors.white,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 50,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        Text(categories[index].name)
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 10,
                    height: 150,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChild() {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      height: MediaQuery.of(context).size.height,
      color: AppColors.background,
      child: BlocBuilder(
        bloc: _getCategoriesBloc,
        builder: (_, state) {
          if (state is GetCategorySuccessState) {
            List<Category> categories = [];
            state.categories.forEach((element) {
              if (element.hasChildren) {
                categories.add(element);
              }
            });
            return PageView.builder(
              controller: _pageController,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                return _buildChildPage(index, categories);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildChildPage(int index, List<Category> categories) {
    List<Category> childCategories = categories[index].children;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Card(
        color: AppColors.white,
        child: GridView.builder(
          itemCount: childCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) {
            return _buildChildItem(index, childCategories);
          },
        ),
      ),
    );
  }

  Widget _buildChildItem(int index, List<Category> childCategories) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO - replace by image
          Container(
            width: 80,
            height: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(childCategories[index].name)
        ],
      ),
    );
  }
}
