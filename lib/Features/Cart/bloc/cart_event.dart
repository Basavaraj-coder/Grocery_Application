part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent{}

class CartItemRemove extends CartEvent{
  final ProductDataModel productDataModel;

  CartItemRemove(this.productDataModel);
}