import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:path/path.dart' as Path;
import 'package:shopme_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopme_mobile/blocs/cart_bloc/cart_state.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_bloc.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart_item/cart_item.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartPageState();

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => CartPage(),
    );
  }
}

class CartPageState extends State<CartPage> {
  late GetUserProfileBloc _getUserProfileBloc;
  late CartBloc _cartBloc;
  late SharedPref _sharedPref;
  late ValueNotifier<double> _totalCostNotifier;

  @override
  void initState() {
    super.initState();
    _getUserProfileBloc = getIt<GetUserProfileBloc>();
    _cartBloc = getIt<CartBloc>();
    _sharedPref = getIt<SharedPref>();
    _totalCostNotifier = ValueNotifier(0);
    _getUserProfileBloc.getUserProfile(_sharedPref.token);

    _cartBloc.stream.listen((event) {
      if (event is GetCartSuccessState) {
        _totalCostNotifier.value = event.cart.totalCost;
      }
    });
  }

  @override
  void dispose() {
    _getUserProfileBloc.close();
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc.getCart(_sharedPref.token);
    return BasePage(
      color: AppColors.background,
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
          "Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            _buildUserInfo(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            _buildCart(),
          ],
        ),
        _buildAddCartButton(),
      ],
    );
  }

  Widget _buildCart() {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        child: BlocBuilder(
          bloc: _cartBloc,
          builder: (_, state) {
            if (state is GetCartSuccessState) {
              Cart cart = state.cart;
              List<CartItem> cartItems = cart.cartItems;
              if (cartItems.isEmpty) {
                return Center(
                  child: Text("Your cart is empty"),
                );
              } else {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) {
                    return _buildCartItem(index, cartItems);
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCartItem(int index, List<CartItem> cartItems) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(cartItems[index].product.imageUrl),
                )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems[index].product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cartItems[index].product.price.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity: " + cartItems[index].quantity.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _cartBloc.deleteCartItem(cartItems[index].id, _sharedPref.token);
                              });
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {},
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            color: AppColors.white,
            child: BlocBuilder(
              bloc: _getUserProfileBloc,
              builder: (_, state) {
                if (state is GetUserProfileSuccessState) {
                  UserProfile userProfile = state.userProfile;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userProfile.firstname + " " + userProfile.lastname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                userProfile.phone,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.navigate_next_outlined,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userProfile.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }

  Widget _buildAddCartButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildTotalCost(),
          Container(
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
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: AppColors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCost() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total cost: ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<double>(
            valueListenable: _totalCostNotifier,
            builder: (_, totalCost, __) => Text(
              totalCost.toString() + " đ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
