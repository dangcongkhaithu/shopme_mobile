import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shopme_mobile/pages/order/tab_children/children_page.dart';
import 'package:shopme_mobile/pages/order/tab_children/delivering_page.dart';
import 'package:shopme_mobile/resources/app_colors.dart';
import 'package:shopme_mobile/widget/page/base_page.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderPageState();

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => OrderPage(),
    );
  }
}

class OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BasePage(
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
            "Order",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Ordered",
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.card_giftcard,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text(
                  "Delivering",
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text(
                  "Delivered",
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.done,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        child: _buildPage(),
      ),
    );
  }

  Widget _buildPage() {
    return TabBarView(
      children: [
        ChildrenPage(status: "ordered"),
        DeliveringPage(),
        ChildrenPage(status: "delivered"),
      ],
    );
  }
}
