import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/blocs/order_bloc/order_bloc.dart';
import 'package:shopme_mobile/blocs/order_bloc/order_state.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/remote/models/remote/order_item/order_item.dart';
import 'package:shopme_mobile/data/schemas/request/remote/order/request_order.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

class DeliveringPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeliveringPageState();
}

class DeliveringPageState extends State<DeliveringPage> {
  late OrderBloc _orderBloc;
  late SharedPref _sharedPref;
  late ValueNotifier<List<OrderItem>> _orderItemsNotifier;
  List<OrderItem> orderItems = [];
  List<Order> orders = [];

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
          if (element.status == "delivering") {
            orders.add(element);
            orderItems.addAll(element.orderItems);
          }
        });
        _orderItemsNotifier.value = orderItems;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            _buildBody(),
          ],
        ),
        _buildReceivedButton(),
      ],
    );
  }

  Widget _buildBody() {
    return SliverToBoxAdapter(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
          )),
    );
  }

  Widget _buildOrderItem(int index, List<OrderItem> orderitems) {
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
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
    );
  }

  Widget _buildReceivedButton() {
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
                orders.forEach((element) {
                  RequestOrder request = new RequestOrder(id: element.id, status: "delivered");
                  _orderBloc.updateStatus(request, _sharedPref.token);
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                "Received",
                style: TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
