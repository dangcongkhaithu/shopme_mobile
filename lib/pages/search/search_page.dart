import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_bloc.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/product_detail/product_detail_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/common/product_widget.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class SearchPage extends StatefulWidget {
  final String keyWord;

  const SearchPage({
    Key? key,
    required this.keyWord,
  }) : super(key: key);

  static MaterialPageRoute getRoute({required String keyWord}) {
    return MaterialPageRoute(
      builder: (context) => SearchPage(keyWord: keyWord),
    );
  }

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = getIt<ProductBloc>();
  }

  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
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
          "Search Result",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    _productBloc.searchProduct(widget.keyWord);
    return BlocBuilder(
      bloc: _productBloc,
      builder: (_, state) {
        if (state is SearchProductSuccessState) {
          List<Product> products = state.products;
          if (products.isEmpty) {
            return Center(
              child: Text("No Result"),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (_, index) {
                return _buildProductItem(index, products);
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildProductItem(int index, List<Product> products) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(ProductDetailPage.getRoute(product: products[index])),
      child: Card(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(products[index].imageUrl),
                    fit: BoxFit.contain,
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                products[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  products[index].price.toString() + " đ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
