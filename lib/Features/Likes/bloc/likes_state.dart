part of 'likes_bloc.dart';

@immutable
sealed class LikesState {}
sealed class LikesActionState extends LikesState{}

final class LikesInitial extends LikesState {}

class LikesLoadingState extends LikesState{}

class LikesSuccessState extends LikesState{
  final List<ProductDataModel> wishListItems;

  LikesSuccessState({required this.wishListItems});
}
class LikesErrorState extends LikesState{}
