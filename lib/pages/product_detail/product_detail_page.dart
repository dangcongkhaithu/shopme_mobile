import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopme_mobile/blocs/cart_bloc/cart_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/data/schemas/request/remote/cart/request_cart.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/pages/common/common_page.dart';
import 'package:shopme_mobile/pages/sign_in/sign_in_page.dart';
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
  late ValueNotifier<int> _quantityNotifier;
  late CartBloc _cartBloc;
  late SharedPref _sharedPref;

  @override
  void initState() {
    super.initState();
    _quantityNotifier = ValueNotifier(1);
    _cartBloc = getIt<CartBloc>();
    _sharedPref = getIt<SharedPref>();

    _cartBloc.stream.listen((event) {
      if(event is AddToCartSuccessState) {
        Fluttertoast.showToast(msg: "Add Success");
      }
    });
  }

  @override
  void dispose() {
    _quantityNotifier.dispose();
    _cartBloc.close();
    super.dispose();
  }

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
        _buildAddCartButton(),
      ],
    );
  }

  Widget _buildAddCartButton() {
    RequestCart request;
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
              onPressed: () {
                if (_sharedPref.token == "") {
                  Navigator.of(context).push(SignInPage.getRoute());
                } else {
                  request = RequestCart(productId: widget.product.id, quantity: _quantityNotifier.value);
                  _cartBloc.addToCart(_sharedPref.token, request);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                "Add To Cart",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.price.toString() + " đ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildQuantityButton(),
              ],
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

  Widget _buildQuantityButton() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _decrementButton(),
            const SizedBox(width: 15),
            ValueListenableBuilder<int>(
              valueListenable: _quantityNotifier,
              builder: (_, quantity, __) => Text(
                quantity.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 15),
            _incrementButton(),
          ],
        ),
      ),
    );
  }

  Widget _incrementButton() {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.red,
      onPressed: () {
        _quantityNotifier.value = _quantityNotifier.value + 1;
      },
    );
  }

  Widget _decrementButton() {
    return FloatingActionButton(
        onPressed: () {
          if (_quantityNotifier.value > 1) {
            _quantityNotifier.value = _quantityNotifier.value - 1;
          }
        },
        child: Icon(Icons.remove, color: Colors.white),
        backgroundColor: Colors.red);
  }
}
