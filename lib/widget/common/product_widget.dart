import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildTitle(),
          Expanded(
            child: _buildProducts(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            TranslateHelper.product,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProducts() {
    if (widget.products.length != 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.products.length,
        itemBuilder: (_, index) {
          return _buildProductItem(index, widget.products);
        },
      );
    }
    return Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProductItem(int index, List<Product> products) {
    return Card(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(products[index].name)
        ],
      ),
    );
  }
}
