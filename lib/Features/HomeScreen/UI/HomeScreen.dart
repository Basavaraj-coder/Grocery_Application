import 'package:bloc_mastering/Features/Cart/UI/Carts.dart';
import 'package:bloc_mastering/Features/HomeScreen/UI/product_tile_widget.dart';
import 'package:bloc_mastering/Features/HomeScreen/bloc/home_screen_bloc.dart';
import 'package:bloc_mastering/Features/Likes/UI/Likes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc eg: event -> to go Bloc emittes-> states, saying hey this event has occurred and
// data is changed states triggers get UI rebuild

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenWidget();
}

class _HomeScreenWidget extends State<HomeScreen> {
  final HomeScreenBloc homeScreenBloc =
      HomeScreenBloc(); // direct instance creation of Bloc
  @override
  void initState() {
    homeScreenBloc.add(
        HomeScreenInitialEvent()); // when we call this HomeScreenInitialEvent
    // --that calls the homeScreenInitialEvent function
    super.initState();
  }

  @override
  //now here my ui should be aware what event user is passing and what state bloc is emitting
  // -- in order to achieve that we need to wrap With BlocConsumer
  // (this BlocConsume will listen to events as well and state)
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      bloc: homeScreenBloc,
      listenWhen: (previous, current) {
        //here in listenWhen only i want to listen when i get action state
        return current is HomeScreenActionsState;
      },
      buildWhen: (previous, current) {
        //here in buildWhen, only i want to build when i don't get action state,i.e is other than action state
        return current is! HomeScreenActionsState;
      },
      listener: (context, state) { // here listener is listening to action-states only
        // --as above mentioned in listenWhen
        if (state is HomeScreenNavigationToCartListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if(state is HomeScreenNavigationToWishListPageActionState){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LikeScreen()));
        }//now lets add two more states of showing scaffold snackbar msg--
        // after adding items to car/wishlist, so goto home_screen_states
        else if(state is HomeScreenItemAddedToCartMsg){
          displaySnackBar(
              context,
              state.msg,
              Icons.shopping_cart);
        }else if(state is HomeScreenItemAddedToWishListMsg){
          displaySnackBar(
              context,
              state.msg,
              Icons.favorite);
        }
      },
      builder: (context, state) { // here builder is listening to non-action-states only
        // --as above mentioned in buildWhen
        switch (state.runtimeType) {
          case HomeScreenLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeScreenLoadedSuccessState:
            final succcessState = state as HomeScreenLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amberAccent,
                  title: const Text("Grocery App"),
                  centerTitle: true, // Centers the title
                  actions: [
                    IconButton(
                        onPressed: () {
                          //after pressing an fav icon,i want to add event to bloc
                          homeScreenBloc.add(HomeScreenWishListNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite)),
                    IconButton(
                        onPressed: () {
                          //after pressing an cart icon,i want to add event to bloc
                          homeScreenBloc.add(HomeScreenCartNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_cart_sharp))
                  ],
                ),
                body: ListView.builder(
                    itemCount: succcessState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        productDataModel:
                            succcessState.products.elementAt(index),
                        homeScreenBloc: homeScreenBloc,
                      );
                    }));
          case HomeScreenErrorState:
            return _buildErrorState(
                state as HomeScreenErrorState); //this i have done becoz,
          // i want to display exception on UI screen, umm actually we don't do that in real scenarios
          // we display short msgs readable msgs,
          default:
            return const Scaffold(
              body: Center(
                child: Text("No Items"),
              ),
            );
        }
      },
    );
  }

  Widget _buildErrorState(HomeScreenErrorState state) {
    return Center(
      child: Text(
        state.errorMessage, // Error message from the state
        style: TextStyle(
          color: Colors.red, // Highlight error in red color
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void displaySnackBar(BuildContext context, String displayMsg, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white, // Icon color
            ),
            const SizedBox(width: 10), // Spacing between icon and text
            Expanded(
              child: Text(
                displayMsg,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Text color
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent.shade700,
        // SnackBar background color
        behavior: SnackBarBehavior.floating,
        // Floating behavior for a modern look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        elevation: 6,
        // Subtle elevation for a rich look
        duration: const Duration(seconds: 2),
        // Visible for 3 seconds
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.amberAccent, // Action button color
          onPressed: () {
            // Undo action logic
          },
        ),
      ),
    );
  }
}
