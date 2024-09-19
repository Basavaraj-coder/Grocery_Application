part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class HomeScreenInitialEvent extends HomeScreenEvent{
  
}
class HomeScreenWishListClickedEvent extends HomeScreenEvent{
  final ProductDataModel productDataModel;

  HomeScreenWishListClickedEvent(this.productDataModel);
}
class HomeScreenCartClickedEvent extends HomeScreenEvent{
  final ProductDataModel productDataModel;

  HomeScreenCartClickedEvent(this.productDataModel);
}
class HomeScreenWishListNavigateEvent extends HomeScreenEvent{

}
class HomeScreenCartNavigateEvent extends HomeScreenEvent{

}