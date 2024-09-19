import 'package:bloc_mastering/Data/cartlist_items.dart';
import 'package:bloc_mastering/Features/Cart/bloc/cart_bloc.dart';
import 'package:bloc_mastering/Features/HomeScreen/bloc/home_screen_bloc.dart';
import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';
import 'package:bloc_mastering/Features/Likes/bloc/likes_bloc.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeScreenBloc? homeScreenBloc; // Optional
  final CartBloc? cartBloc; // Optional
  final LikesBloc? likesBloc;
  final bool isInCart;

  ProductTile(
      {super.key,
      this.homeScreenBloc,
      this.cartBloc,
      this.likesBloc,
      this.isInCart=false,
      required this.productDataModel}); // Indicate if the widget is in the cart context

  @override
  State<StatefulWidget> createState() =>
      ProductTileWidget(
          productDataModel: productDataModel,
          homeScreenBloc:homeScreenBloc,
          cartBloc: cartBloc,
          likesBloc: likesBloc,
          isInCart: isInCart);
}

class ProductTileWidget extends State<ProductTile> {
  final ProductDataModel productDataModel;
  final HomeScreenBloc? homeScreenBloc; // Optional
  final CartBloc? cartBloc; // Optional
  final LikesBloc? likesBloc;
  final bool isInCart; // Indicate if the widget is in the cart context
  ProductTileWidget({
    required this.productDataModel,
    this.homeScreenBloc,
    this.cartBloc,
    this.likesBloc,
    this.isInCart = false // Default to false (home screen)
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cartBloc == null && likesBloc == null)
          //homeScreen
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  const Border(bottom: BorderSide(color: Colors.amberAccent)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Offer Tag
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        productDataModel.imageUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '10% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        productDataModel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Product Description
                      Text(
                        productDataModel.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Product Price and Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Price
                          Text(
                            '\$${productDataModel.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          // Buttons for Cart and Wishlist
                          Row(
                            children: [
                              // Wishlist Button
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.redAccent,
                                onPressed: () {
                                  homeScreenBloc?.add(
                                      HomeScreenWishListClickedEvent(
                                          productDataModel));
                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to WishList!",
                                  //     Icons.favorite);
                                },
                              ),
                              // Add to Cart Button
                              IconButton(
                                icon: const Icon(Icons.shopping_cart_outlined),
                                color: Colors.green,
                                onPressed: () {
                                  homeScreenBloc?.add(
                                      HomeScreenCartClickedEvent(
                                          productDataModel));
                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to cart!",
                                  //     Icons.shopping_cart);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else if (homeScreenBloc == null && cartBloc == null)
          //likes
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  const Border(bottom: BorderSide(color: Colors.amberAccent)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Offer Tag
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        productDataModel.imageUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '10% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        productDataModel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Product Description
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productDataModel.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //BUY Button
                          OutlinedButton(
                              onPressed: () {
                                // Action to perform when the button is pressed
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                // Text color
                                textStyle: const TextStyle(fontSize: 12),
                                side: const BorderSide(color: Colors.grey),
                                // Border color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional: Rounded corners
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                // Adjust padding as needed
                                child: Text("BUY"),
                              ))
                        ],
                      ),

                      const SizedBox(height: 10),
                      // Product Price and Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Price
                          Text(
                            '\$${productDataModel.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          // Buttons for Cart and Wishlist
                          Row(
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.remove),
                              //   color: Colors.redAccent,
                              //   onPressed: () {
                              //     //likesBloc?.add();
                              //     //either we can call snackbar here like traditional coding --
                              //     //else use states to display same code i will write in HomeScreen.dart
                              //     // displaySnackBar(
                              //     //     context,
                              //     //     "${productDataModel.name} added to WishList!",
                              //     //     Icons.favorite);
                              //   },
                              // ),
                              // remove from Cart Button
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.green,
                                onPressed: () {
                                  likesBloc
                                      ?.add(LikesRemoveEvent(productDataModel));
                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to cart!",
                                  //     Icons.shopping_cart);
                                },
                              ),
                              //Wishlist Button
                              // IconButton(
                              //   icon: const Icon(Icons.add),
                              //   color: Colors.redAccent,
                              //   onPressed: () {
                              //     // cartBloc?.add(
                              //     //     HomeScreenWishListClickedEvent(
                              //     //         productDataModel));
                              //     //either we can call snackbar here like traditional coding --
                              //     //else use states to display same code i will write in HomeScreen.dart
                              //     // displaySnackBar(
                              //     //     context,
                              //     //     "${productDataModel.name} added to WishList!",
                              //     //     Icons.favorite);
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  const Border(bottom: BorderSide(color: Colors.amberAccent)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Offer Tag
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        productDataModel.imageUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '10% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productDataModel.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Qty:${1}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Product Description
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productDataModel.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //BUY Button
                          OutlinedButton(
                              onPressed: () {
                                // Action to perform when the button is pressed
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                // Text color
                                textStyle: const TextStyle(fontSize: 12),
                                side: const BorderSide(color: Colors.grey),
                                // Border color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional: Rounded corners
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                // Adjust padding as needed
                                child: Text("BUY"),
                              ))
                        ],
                      ),

                      const SizedBox(height: 10),
                      // Product Price and Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Price
                          Text(
                            '\$${productDataModel.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          // Buttons for Cart and Wishlist
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.redAccent,
                                onPressed: () {
                                  // cartBloc?.add(CartInitialEvent());

                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to WishList!",
                                  //     Icons.favorite);
                                },
                              ),
                              // remove from Cart Button
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.green,
                                onPressed: () {
                                  cartBloc
                                      ?.add(CartItemRemove(productDataModel));
                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to cart!",
                                  //     Icons.shopping_cart);
                                },
                              ),
                              //Wishlist Button
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.redAccent,
                                onPressed: () {
                                  // cartBloc?.add(
                                  //     HomeScreenWishListClickedEvent(
                                  //         productDataModel));
                                  //either we can call snackbar here like traditional coding --
                                  //else use states to display same code i will write in HomeScreen.dart
                                  // displaySnackBar(
                                  //     context,
                                  //     "${productDataModel.name} added to WishList!",
                                  //     Icons.favorite);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
//initially i was showing snackbar msg of successfully added to cart/wish here in product_tile_widget
//now i am using states and this same code i have copied to homescreen.dart with states concepts
// void displaySnackBar(BuildContext context, String displayMsg, IconData icon) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Row(
//         children: [
//            Icon(
//             icon,
//             color: Colors.white, // Icon color
//           ),
//           const SizedBox(width: 10), // Spacing between icon and text
//           Expanded(
//             child: Text(
//               displayMsg,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white, // Text color
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.greenAccent.shade700,
//       // SnackBar background color
//       behavior: SnackBarBehavior.floating,
//       // Floating behavior for a modern look
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10), // Rounded corners
//       ),
//       elevation: 6,
//       // Subtle elevation for a rich look
//       duration: const Duration(seconds: 3),
//       // Visible for 3 seconds
//       action: SnackBarAction(
//         label: 'Undo',
//         textColor: Colors.amberAccent, // Action button color
//         onPressed: () {
//           // Undo action logic
//         },
//       ),
//     ),
//   );
// }
}
