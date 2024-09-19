import 'package:bloc_mastering/Features/Cart/bloc/cart_bloc.dart';
import 'package:bloc_mastering/Features/HomeScreen/UI/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => Cart();
}

class Cart extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        //blocConsumer is used to listen the states and build the UI --
        // and same parameters it accepts builder and listeners
        body: BlocConsumer<CartBloc,CartState>(
          bloc:cartBloc,
            listenWhen:(previous, current)=> current is CartActionState,
            buildWhen: (previous, current) => current is CartState,
            builder: (context, state) {
            switch(state.runtimeType){
              case CartLoadingState:
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case CartSuccessState:
                final success = state as CartSuccessState;
                if(success.cartItems.isEmpty){
                  return const Scaffold(
                    body: Center(
                      child: Text("No Items"),
                    ),
                  );
                }else{
                  return Scaffold(
                    body: ListView.builder(
                        itemCount: success.cartItems.length,
                        itemBuilder: (context, index){
                          return ProductTile(
                            productDataModel: state.cartItems[index],
                            cartBloc: cartBloc,
                            isInCart: true,);
                        }),
                  );
                }
              case CartErrorState:
                return const Scaffold(
                  backgroundColor: Colors.red,
                  body: Center(
                    child: Text("Error in Loading data"),
                  ),
                );
              default:
                return const Scaffold(
                  body: Center(
                    child: Text("No Items"),
                  ),
                );
            }
              //return Container();
              
            }, listener: (context, state) {
            }
        ));
  }
}
