import 'package:bloc/bloc.dart';
import 'package:cart_product_ca_app/core/params/no_param.dart';
import 'package:cart_product_ca_app/features/home/domain/usecases/get_home_product.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeProduct _getProduct;
  HomeBloc(this._getProduct) : super(HomeState()) {
    on<GetProductHomeEvent>(_homeProduct);
  }

  void _homeProduct(GetProductHomeEvent event, Emitter<HomeState> emit) async {
    emit(ProductLoadingHomeState());

    final getproduct = await _getProduct(NoParam());

    getproduct.fold((error) {
      emit(FailurLoadPorductHomeState(failure: error));
    }, (success) {
      print(success);
      emit(ProductLoadedHomeState(products: success));
    });
  }
}
