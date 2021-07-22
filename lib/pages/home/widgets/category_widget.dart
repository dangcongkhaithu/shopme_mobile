import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopme_mobile/data/models/remote/category/category.dart';
import 'package:shopme_mobile/data/sources/remote/services/api_service.dart';
import 'package:dio/dio.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

    return FutureBuilder<List<Category>>(
      future: client.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Category>? categories = snapshot.data;
          return _buildCategory(context, categories);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCategory(BuildContext context, List<Category>? categories) {
    return Center(
      child: Text((categories != null) ? categories[0].name : ""),
    );
  }
}
