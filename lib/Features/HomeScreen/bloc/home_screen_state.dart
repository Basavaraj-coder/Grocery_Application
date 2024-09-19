part of 'home_screen_bloc.dart';

//states are of two types build state and actionable state
@immutable
sealed class HomeScreenState {} // this is to Build Ui, when user enters, the UI needs to build--
// and this does that, so it is know as build states

abstract class HomeScreenActionsState extends HomeScreenState {
  //this state take some actions
} //actionable state

final class HomeScreenInitial
    extends HomeScreenState {} //this we have to use for Build Ui state

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenLoadedSuccessState extends HomeScreenState {
  //now here after loading Successfully, we will get list of products
  final List<ProductDataModel> products;

  HomeScreenLoadedSuccessState({required this.products});
}

class HomeScreenErrorState extends HomeScreenState {
  final String errorMessage;

  HomeScreenErrorState(this.errorMessage);
}

//action States
//in action states ur UI is not building in this below case, it is just navigating here
class HomeScreenNavigationToWishListPageActionState
    extends HomeScreenActionsState {} //this class for when user clicks on Wishlist(i.e Heart Icon) it should navigate to WishList page

class HomeScreenNavigationToCartListPageActionState
    extends HomeScreenActionsState {} //this class for when user clicks on cart-list(i.e Heart Icon) it should navigate to WishList page

//adding two more states for showing snackbar msgs after adding items to cart/wishlist
class HomeScreenItemAddedToCartMsg extends HomeScreenActionsState{
  final String msg;

  HomeScreenItemAddedToCartMsg(this.msg);
}
class HomeScreenItemAddedToWishListMsg extends HomeScreenActionsState{
  final String msg;

  HomeScreenItemAddedToWishListMsg(this.msg);
}