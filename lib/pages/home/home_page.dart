import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_bloc.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/home/widgets/category_widget.dart';
import 'package:shopme_mobile/pages/home/widgets/header_widget.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/common/product_widget.dart';
import 'package:shopme_mobile/widget/common/search_bar_widget.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State<HomePage> {
  late ProductBloc _productBloc;
  late ValueNotifier<List<Product>> _productsNotifier;

  @override
  void initState() {
    super.initState();
    _productBloc = getIt<ProductBloc>();
    _productsNotifier = ValueNotifier([]);

    _productBloc.stream.listen((event) {
      if (event is GetProductSuccessState) {
        _productsNotifier.value = event.products;
      }
    });
  }

  @override
  void dispose() {
    _productBloc.close();
    _productsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    final double marginTop = 150;
    return Stack(
      //fit: StackFit.expand,
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: marginTop)),
            _buildHeader(),
            SliverToBoxAdapter(child: const SizedBox(height: 10)),
            _buildCategory(),
            SliverToBoxAdapter(child: const SizedBox(height: 10)),
            _buildProduct(),
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

  Widget _buildProduct() {
    _productBloc.getProducts();
    return SliverToBoxAdapter(
      child: ValueListenableBuilder<List<Product>>(
        valueListenable: _productsNotifier,
        builder: (_, products, __) {
          return ProductWidget(
            products: products,
          );
        },
      ),
    );
  }
}
