import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';

class CartListItems{
  // Initialize _wishlist as an empty list
  // List<ProductDataModel> _cartlist = [];
  //
  // // Getter to retrieve wishlist
  // List<ProductDataModel> get getCartList => _cartlist;
  //
  // // Method to add a single product to the wishlist
  // void addCartList(ProductDataModel product) {
  //   _cartlist.add(product);
  // }

  // Singleton instance
  static final CartListItems _instance = CartListItems._internal();

  // Private constructor
  CartListItems._internal();

  // Factory constructor to return the same instance
  factory CartListItems() {
    return _instance;
  }

  // Initialize wishlist
  final List<ProductDataModel> _cartlist = [];

  List<ProductDataModel> get getCartList => _cartlist;

  // Method to add a product to the wishlist
  void addCartList(ProductDataModel productDataModel) {
    _cartlist.add(productDataModel);
  }

  void removeCartItem(ProductDataModel productDataModel) {
    _cartlist.remove(productDataModel);
  }
}