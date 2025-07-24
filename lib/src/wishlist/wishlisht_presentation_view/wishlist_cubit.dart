import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:e_triad/src/wishlist/domain/use_cases/add_to_wishlist.dart';
import 'package:e_triad/src/wishlist/domain/use_cases/get_user_wishlist.dart';
import 'package:e_triad/src/wishlist/domain/use_cases/remove_from_wishlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required GetUserWishlist getUserWishlist,
    required AddToWishlist addToWishlist,
    required RemoveFromWishlist removeFromWishlist,
  }) : _addToWishlist = addToWishlist,
       _getUserWishlist = getUserWishlist,
       _removeFromWishlist = removeFromWishlist,

       super(const StateInitialWishlist());

  final GetUserWishlist _getUserWishlist;
  final AddToWishlist _addToWishlist;
  final RemoveFromWishlist _removeFromWishlist;

  Future<void> getUserWishlist(String userId) async {
    if (state is StateFetchedUserWishlist) {
      return;
    }
    if (state is! StateWishlistUpdating) {
      emit(const StateWishlistLoading());
    }
    final results = await _getUserWishlist(userId);
    results.fold((failure) => emit(StateWishlistError(failure.errorMessage)), (
      wishlistProduts,
    ) {
      emit(StateFetchedUserWishlist(wishlistProduts));
    });
  }

  Future<void> addToWishlist(String userId, String productId) async {
     
    final results = await _addToWishlist(
      AddToWishlistParams(userId, productId),
    );
    results.fold((failure) => emit(StateWishlistError(failure.errorMessage)), 
    (_) async {
        final wishlistResult = await _getUserWishlist(userId);

        wishlistResult.fold(
          (failure) => emit(StateWishlistError(failure.errorMessage)),
          (wishlist) {
            emit(StateFetchedUserWishlist(wishlist));
          },
        );
        if (!isClosed) {
          emit(StateWishlistAdded());
        }
      },);
  }

  Future<void> removeFromWishlist(String userId, String productId) async {
    final currentState =
        state is StateFetchedUserWishlist
            ? (state as StateFetchedUserWishlist).wishlistProducts
            : <dynamic>[];
    emit(StateWishlistUpdating(currentState));
    final results = await _removeFromWishlist(
      RemoveFromWishlistParams(userId, productId),
    );

    results.fold(
      (failure) {
        if (!isClosed) {
          emit(StateWishlistError(failure.errorMessage));
        }
      },
      (_) async {
        final wishlistResult = await _getUserWishlist(userId);

        wishlistResult.fold(
          (failure) => emit(StateWishlistError(failure.errorMessage)),
          (wishlist) {
            emit(StateFetchedUserWishlist(wishlist));
          },
        );
        if (!isClosed) {
          emit(StateWishlistRemoved());
        }
      },
    );
  }

  
}
