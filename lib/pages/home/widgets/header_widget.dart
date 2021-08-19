import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';

class HeaderWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildSlider();
  }

  Widget _buildSlider() {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            height: _size.height * 0.2,
            width: _size.width,
            child: Carousel(
              indicatorBarColor: Colors.black.withOpacity(0),
              autoScrollDuration: Duration(seconds: 2),
              animationPageDuration: Duration(milliseconds: 500),
              activateIndicatorColor: Colors.black,
              animationPageCurve: Curves.bounceInOut,
              unActivatedIndicatorColor: Colors.grey,
              items: [
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.yellow,
                )
              ],
            ))
      ],
    );
  }
}
