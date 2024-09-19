import 'package:bloc_mastering/Features/Cart/bloc/cart_bloc.dart';
import 'package:bloc_mastering/Features/HomeScreen/UI/product_tile_widget.dart';
import 'package:bloc_mastering/Features/Likes/bloc/likes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<StatefulWidget> createState() => Like();
}

class Like extends State<LikeScreen> {
  final LikesBloc _likesBloc = LikesBloc();

  @override
  void initState() {
    _likesBloc.add(LikesInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Likes"),
        ),
        body: BlocConsumer(
            bloc: _likesBloc,
            builder: (context, state) {
              // used to buildUI
              switch (state.runtimeType) {
                case LikesLoadingState:
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case LikesSuccessState:
                  final listOfLikesInstance = state as LikesSuccessState;
                  if (listOfLikesInstance.wishListItems.isEmpty) {
                    return const Scaffold(
                      body: Center(
                        child: Text("No Items"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: listOfLikesInstance.wishListItems.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              likesBloc: _likesBloc,
                              productDataModel:
                                  listOfLikesInstance.wishListItems[index]);
                          //getting each element to display on UI
                        });
                  }
                case LikesErrorState:
                  return const Scaffold(
                    body: Center(
                      child: Text("Error in loading data"),
                    ),
                  );
                default:
                  return const Scaffold(
                    body: Center(
                      child: Text("No Items"),
                    ),
                  );
              }
            },
            listener: (context, state) {}));
  }
}
