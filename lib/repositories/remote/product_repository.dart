import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/product_datasource.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasource _productDatasource;

  ProductRepositoryImpl() : _productDatasource = getIt<ProductDatasource>();

  @override
  Future<List<Product>> getProducts() {
    return _productDatasource.getProducts();
  }
}
