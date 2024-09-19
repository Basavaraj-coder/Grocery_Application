import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/Data/Products_data.dart';
import 'package:bloc_mastering/Data/cartlist_items.dart';
import 'package:bloc_mastering/Data/wishlist_items.dart';
import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenInitialEvent>(homeScreenInitialEvent);
    on<HomeScreenWishListClickedEvent>(homeScreenWishListClickedEvent);
    //on this HomeScreenWishListClickedEvent event call that --
    // homeScreenWishListClickedEvent function/method
    on<HomeScreenCartClickedEvent>(homeScreenCartClickedEvent);

    on<HomeScreenWishListNavigateEvent>(homeScreenWishListNavigateEvent);
    on<HomeScreenCartNavigateEvent>(homeScreenCartNavigateEvent);
  }

  FutureOr<void> homeScreenWishListClickedEvent(
      HomeScreenWishListClickedEvent event, Emitter<HomeScreenState> emit) {
    print("Clicked on WishList button");
    //this is how pass to event frm bloc
    WishListItems().addWishList(event.productDataModel);//adding that specific element to list
    //now after adding items need to emit state for displaying msg on snackbar
    emit(HomeScreenItemAddedToWishListMsg("${event.productDataModel.name} added to wishlist!"));

    // Emit the updated wishlist state and show the message
    //emit(HomeScreenNavigationToCartListPageActionState());
  }

  FutureOr<void> homeScreenCartClickedEvent(
      HomeScreenCartClickedEvent event, Emitter<HomeScreenState> emit) {
    //print("Clicked on cart button");
    //this is how to pass event frm bloc
    // Add product to the singleton wishlist instance
    CartListItems().addCartList(event.productDataModel);
    // Optionally, emit a state for displaying the snackbar message
    //adding that specific element to list
    //now after adding items need to emit state for displaying msg on snackbar
    emit(HomeScreenItemAddedToCartMsg("${event.productDataModel.name} added to cartlist!"));

    // Emit the updated wishlist state and show the message
   // emit(HomeScreenNavigationToCartListPageActionState());
  }

  FutureOr<void> homeScreenWishListNavigateEvent(
      HomeScreenWishListNavigateEvent event, Emitter<HomeScreenState> emit) {
    print("Clicked on wishlist navigate button");
    //so here i have to listen the states and take some action
    //now here emit the action state, becos we have to navigate to that specific page
    emit(HomeScreenNavigationToWishListPageActionState());
  }

  FutureOr<void> homeScreenCartNavigateEvent(
      HomeScreenCartNavigateEvent event, Emitter<HomeScreenState> emit) {
    print("Clicked on Cart navigate button");
    //now here emit the action state, becos we have to navigate to that specific page
    emit(HomeScreenNavigationToCartListPageActionState());
  }

  FutureOr<void> homeScreenInitialEvent(
      //to emit this state/to get this state in UI,
      // i need to add this initial event in homeScreen in initState()
      //ok why in initState, becos as soon app open i want to add initial event
      //initial event is handling loading,and loading success states,

      HomeScreenInitialEvent event,
      Emitter<HomeScreenState> emit) async {
    //now when my initial event is added to bloc i want to emit a state,
    // think logically first would be loading state logically, so emit it
    emit(HomeScreenLoadingState());
    //now as we are not using mongo db/Firebase, we are using local db, so i will --
    // purposefully add async await
    await Future.delayed(const Duration(seconds: 3));

    try {
      emit(HomeScreenLoadedSuccessState(
          products: Products_Data.groceryProducts
              .map((e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl']))
              .toList()));
    } catch (error) {
      // print("Error during Loading products : ${error.toString()}");
      emit(HomeScreenErrorState(error.toString()));//added/updated by me
    }
  }
}
