import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme_mobile/blocs/order_bloc/order_bloc.dart';
import 'package:shopme_mobile/blocs/order_bloc/order_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/remote/models/remote/order_item/order_item.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class ChildrenPage extends StatefulWidget {
  final String status;

  const ChildrenPage({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChildrenPageState();
}

class ChildrenPageState extends State<ChildrenPage> {
  late OrderBloc _orderBloc;
  late SharedPref _sharedPref;
  late ValueNotifier<List<OrderItem>> _orderItemsNotifier;
  List<OrderItem> orderItems = [];

  @override
  void initState() {
    super.initState();
    _orderBloc = getIt<OrderBloc>();
    _sharedPref = getIt<SharedPref>();
    _orderItemsNotifier = ValueNotifier([]);

    _orderBloc.getAllOrders(_sharedPref.token);

    _orderBloc.stream.listen((event) {
      if (event is GetAllOrderSuccessState) {
        event.orders.forEach((element) {
          if (element.status == widget.status) {
            orderItems.addAll(element.orderItems);
          }
        });
        _orderItemsNotifier.value = orderItems;
      }
    });
  }

  @override
  void dispose() {
    _orderBloc.close();
    _orderItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(child: CustomScrollView(
        slivers: [
        _buildBody(),
      ],
    ));
  }

  Widget _buildBody() {
    return SliverToBoxAdapter(
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          color: AppColors.white,
          child: ValueListenableBuilder<List<OrderItem>>(
            valueListenable: _orderItemsNotifier,
            builder: (_, orderItems, __) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: orderItems.length,
                itemBuilder: (_, index) {
                  return _buildOrderItem(index, orderItems);
                },
              );
            },
          )
      ),
    );
  }

  Widget _buildOrderItem(int index, List<OrderItem> orderitems) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
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
                      image: NetworkImage(orderitems[index].product.imageUrl),
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderitems[index].product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      orderitems[index].product.price.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Quantity: " + orderItems[index].quantity.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],

                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 0.5,
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
    );
  }

}