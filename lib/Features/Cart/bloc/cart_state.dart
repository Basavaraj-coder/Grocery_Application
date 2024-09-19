part of 'cart_bloc.dart';

@immutable
sealed class CartState {}
sealed class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartSuccessState extends CartState{
   final List<ProductDataModel> cartItems;

   //CartSuccessState({required this.cartItems});
   CartSuccessState(this.cartItems);
}

class CartLoadingState extends CartState{}
class CartErrorState extends CartState{}



// class CartEmptyState extends CartActionState{}
