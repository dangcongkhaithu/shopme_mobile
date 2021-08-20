import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/pages/common/common_page.dart';
import 'package:shopme_mobile/pages/home/widgets/header_widget.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductDetailPageState();

  static MaterialPageRoute getRoute({required Product product}) {
    return MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: product,
      ),
    );
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(
              color: AppColors.mainColor,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
          child: _buildAppBar(),
        ),
      ),
      child: _buildPage(),
    );
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Row(
              children: [
                CircularButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).push(CommonPage.getRoute()),
                ),
                const SizedBox(width: 10),
                CircularButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            _buildImages(),
            SliverToBoxAdapter(
              child: const SizedBox(
                height: 20,
              ),
            ),
            _buildTitleProduct(),
          ],
        ),
        _buildAddCartButton()
      ],
    );
  }

  Widget _buildAddCartButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(width: 1, color: AppColors.border),
          ),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              //TODO cast to TranslateHelper
              child: Text(
                "Chon Mua",
                style: TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImages() {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(widget.product.imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleProduct() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.price.toString() + " đ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
