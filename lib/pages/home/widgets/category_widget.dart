import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_state.dart';
import 'package:shopme_mobile/core/common/helpers/translate_helper.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/di/injection.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  late CategoryBloc _getCategoriesBloc;

  @override
  void initState() {
    super.initState();
    _getCategoriesBloc = getIt<CategoryBloc>();
    _getCategoriesBloc.getAllCategories();
  }

  @override
  void dispose() {
    _getCategoriesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.white,
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 10),
          Expanded(
            child: _buildCategories(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            TranslateHelper.category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            onPressed: () {},
            child: Text(
              TranslateHelper.readMore,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCategories() {
    return BlocBuilder(
      bloc: _getCategoriesBloc,
      builder: (_, state) {
        print(state);
        if (state is GetCategorySuccessState) {
          List<Category> categories = state.categories.getRange(0, 10).toList();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (_, int index) {
              return _buildCategoryItem(index, categories);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCategoryItem(int index, List<Category> categories) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(categories[index].imageUrl),
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(height: 5),
          Text(
            categories[index].categoryName,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
