import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:shopme_mobile/resources/app_colors.dart';

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
            height: 200,
            width: _size.width,
            color: AppColors.white,
            child: Carousel(
              indicatorBarColor: Colors.black.withOpacity(0),
              autoScrollDuration: Duration(seconds: 2),
              animationPageDuration: Duration(milliseconds: 500),
              activateIndicatorColor: Colors.black,
              animationPageCurve: Curves.bounceInOut,
              unActivatedIndicatorColor: Colors.grey,
              items: [
                _buildImage("assets/images/image_slide_1.png"),
                _buildImage("assets/images/image_slide_2.jpeg"),
                _buildImage("assets/images/image_slide_3.jpeg"),
              ],
            ))
      ],
    );
  }

  Widget _buildImage(String path) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
        )
      ),
    );
  }
}
