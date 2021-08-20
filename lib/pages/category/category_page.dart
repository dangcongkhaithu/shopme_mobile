import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/product_detail/product_detail_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/common/search_bar_widget.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class CategoryPage extends StatefulWidget {
  final int selectedCategoryIndex;

  const CategoryPage({
    Key? key,
    this.selectedCategoryIndex = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryPageState();

  static MaterialPageRoute getRoute({int selectedCategoryIndex = 0}) {
    return MaterialPageRoute(
      builder: (context) => CategoryPage(selectedCategoryIndex: selectedCategoryIndex),
    );
  }
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
    _selectedNotifier = ValueNotifier(widget.selectedCategoryIndex);
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
              List<Category> categories = state.categories;
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
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(categories[index].imageUrl),
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Text(categories[index].categoryName)
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
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(categories[index].imageUrl),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(height: 10),
                        Text(categories[index].categoryName)
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
            List<Category> categories = state.categories;
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
    List<Product> products = categories[index].products;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Card(
        color: AppColors.white,
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) {
            return _buildChildItem(index, products);
          },
        ),
      ),
    );
  }

  Widget _buildChildItem(int index, List<Product> products) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(ProductDetailPage.getRoute(product: products[index])),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(products[index].imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                products[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
