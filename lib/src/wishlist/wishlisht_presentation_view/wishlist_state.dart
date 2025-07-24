part of 'wishlist_cubit.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

final class StateWishlistLoading extends WishlistState {
  const StateWishlistLoading();
}

final class StateInitialWishlist extends WishlistState {
  const StateInitialWishlist();
}

class StateWishlistUpdating extends WishlistState {
  const StateWishlistUpdating(this.wishlistProducts);
  
  final List<dynamic> wishlistProducts;
  
  @override
  List<Object> get props => [wishlistProducts];
}

final class StateFetchedUserWishlist extends WishlistState {
  const StateFetchedUserWishlist(this.wishlistProducts);

  final List<Wishlist> wishlistProducts;

  @override
  List<Object?> get props => [wishlistProducts];
}

final class StateWishlistAdded extends WishlistState {
   
  const StateWishlistAdded();
 
}

final class StateWishlistRemoved extends WishlistState {
   const StateWishlistRemoved();
  
}

class WishlistOperationSuccess extends WishlistState {
  const WishlistOperationSuccess(this.message, this.items);
  final String message;
  final List<Wishlist> items;
   @override
  List<Object?> get props => [items];
}

final class StateWishlistError extends WishlistState {
  const StateWishlistError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
