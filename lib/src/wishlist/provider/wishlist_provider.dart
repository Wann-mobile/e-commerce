import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:flutter/material.dart';


class WishlistProvider extends ChangeNotifier {
  WishlistProvider._internal();

  static final instance = WishlistProvider._internal();

  final Set<String> _wishlist = {};

  bool contains(String id) => _wishlist.contains(id);

  Set<String> get wishlist => _wishlist;

  void addToWishlist(String id) async {
    _wishlist.add(id);
    _wishlistCacheHelper;
    notifyListeners();
  }

  void removeFromWishlist(String id) {
    _wishlist.remove(id);
    _wishlistCacheHelper();
    notifyListeners();
  }

  Future<void> getWishlistAvailable() async{
    final availableWishlist = sl<CacheHelper>().getWishlist();
    _wishlist
    ..clear()
    ..addAll(availableWishlist as Iterable<String>);
    notifyListeners();
  }
   

  Future<void> _wishlistCacheHelper() async {
    sl<CacheHelper>().cacheWishlist(_wishlist);
  }
}
