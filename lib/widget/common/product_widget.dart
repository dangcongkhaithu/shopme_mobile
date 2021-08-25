import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/pages/product_detail/product_detail_page.dart';

class ProductWidget extends StatefulWidget {
  final List<Product> products;

  const ProductWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildProducts();
  }

  Widget _buildProducts() {
    if (widget.products.length != 0) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.65,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return _buildProductItem(index, widget.products);
          },
          childCount: widget.products.length,
        ),
      );
    }
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      ),
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
