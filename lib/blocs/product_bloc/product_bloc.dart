import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/product_repository.dart';

class ProductBloc extends BaseBloc with SingleBlocMixin {
  ProductRepository _repository = getIt<ProductRepository>();

  void getProducts() {
    single<List<Product>>(() => _repository.getProducts(),
        onSuccess: (products) => GetProductSuccessState(products: products));
  }
}
