import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/Data/wishlist_items.dart';
import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesBloc() : super(LikesInitial()) {
    on<LikesInitialEvent>(likesInitialEvent);
    on<LikesRemoveEvent>(likesRemoveEvent);
  }

  FutureOr<void> likesInitialEvent(LikesInitialEvent event, Emitter<LikesState> emit) async{
    emit(LikesLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    try{
      emit(LikesSuccessState(wishListItems: WishListItems().getWishList));//only get the list of
      // item when user clicks on AppBar Like icon, which were added in ProducTileWidget,
    }catch(exception){
      emit(LikesErrorState());
    }
  }

  FutureOr<void> likesRemoveEvent(LikesRemoveEvent event, Emitter<LikesState> emit) {
    //remove the data from wishlist
    WishListItems().removeWishList(event.productDataModel);

    //emit state after deleting,we need to rebuild the state of UI so simple call --
    // LikesSuccessState which loads/gets whole list of again
    emit(LikesSuccessState(wishListItems: WishListItems().getWishList));
  }
}
