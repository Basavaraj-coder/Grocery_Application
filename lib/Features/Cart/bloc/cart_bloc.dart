import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/Data/cartlist_items.dart';
import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemRemove>(cartItemRemove);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    try {
      emit(CartSuccessState(CartListItems().getCartList));//only get the list of
      // item when user clicks on AppBar Cart icon, which were added in ProducTileWidget,
    } catch (e) {
      emit(CartErrorState());
    }
  }

  FutureOr<void> cartItemRemove(CartItemRemove event, Emitter<CartState> emit) {
    CartListItems cartListItems = CartListItems();
    cartListItems.removeCartItem(event.productDataModel); //remove from list

    emit(CartSuccessState(CartListItems().getCartList)); //get all listitems after removing
   // emit(CartEmptyState());
  }
}
