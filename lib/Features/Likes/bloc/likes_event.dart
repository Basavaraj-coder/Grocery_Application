part of 'likes_bloc.dart';

@immutable
sealed class LikesEvent {}

class LikesInitialEvent extends LikesEvent{}//loading and success and error state here
class LikesRemoveEvent extends LikesEvent{
  //need product details of specific item to remove from list
  final ProductDataModel productDataModel;

  LikesRemoveEvent(this.productDataModel);
} // remove items from likes list
