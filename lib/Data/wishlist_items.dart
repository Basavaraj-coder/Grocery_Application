import 'package:bloc_mastering/Features/HomeScreen/models/home_product_data_model.dart';

class WishListItems{
  // // Initialize _wishlist as an empty list
  // List<ProductDataModel> _wishlist = [];
  //
  // // Getter to retrieve wishlist
  // List<ProductDataModel> get getWishList => _wishlist;
  //
  // // Method to add a single product to the wishlist
  // void addWishList(ProductDataModel product) {
  //   _wishlist.add(product);
  // }

  // Singleton instance
  static final WishListItems _instance = WishListItems._internal();

  // Private constructor
  WishListItems._internal();

  // Factory constructor to return the same instance
  factory WishListItems() {
    return _instance;
  }

  // Initialize wishlist
  List<ProductDataModel> _wishlist = [];

  List<ProductDataModel> get getWishList => _wishlist;

  // Method to add a product to the wishlist
  void addWishList(ProductDataModel productDataModel) {
    _wishlist.add(productDataModel);
  }

  void removeWishList(ProductDataModel productDataModel){
    _wishlist.remove(productDataModel);
  }
}