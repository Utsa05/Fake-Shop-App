import 'package:bloc/bloc.dart';
import 'package:cart_product_ca_app/core/error/failure.dart';
import 'package:cart_product_ca_app/features/product/domain/usecases/get_product.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProduct _getProduct;
  ProductBloc(this._getProduct) : super(ProductState()) {
    on<GetProductByIdEvent>(_getProductbyId);
  }

  void _getProductbyId(
      GetProductByIdEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    final response = await _getProduct(event.productID);
    response.fold((error) => emit(ProductFailureState(failure: error)),
        (success) {
      emit(ProductLoadedState(product: success));
    });
  }
}
