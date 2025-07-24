import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/add_to_cart.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/get_cart_product_id.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/get_user_cart.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/get_user_cart_count.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/remove_product_quantity.dart';
import 'package:e_triad/src/cart_product/domain/use_cases/update_product_quantity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required AddToCart addToCart,
    required RemoveProductQuantity removeProductFromCart,
    required UpdateProductQuantity updateProductQuantity,
    required GetUserCart getUserCart,
    required GetUserCartCount getUserCartCount,
    required GetCartProductById getCartProductById,
  }) : _addToCart = addToCart,
       _removeProductFromCart = removeProductFromCart,
       _updateProductQuantity = updateProductQuantity,
       _getCartProductById = getCartProductById,
       _getUserCart = getUserCart,
       _getUserCartCount = getUserCartCount,
       super(const StateCartLoading());

  final AddToCart _addToCart;
  final RemoveProductQuantity _removeProductFromCart;
  final UpdateProductQuantity _updateProductQuantity;
  final GetUserCart _getUserCart;
  final GetUserCartCount _getUserCartCount;
  final GetCartProductById _getCartProductById;

  Future<void> addToCart({
    required String userId,
    required String productId,
    required int? quantity,
    required String selectedSize,
  }) async {
    emit(const StateCartLoading());
    final result = await _addToCart(
      AddToCartParam(
        productId: productId,
        userId: userId,
        quantity: quantity,
        selectedSize: selectedSize,
      ),
    );
    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (_) => emit(StateAddedToCart()),
    );
  }

  Future<void> getUserCart(String userId) async {
    if (state is! StateCartUpdating) {
      emit(const StateCartLoading());
    }
    
    final result = await _getUserCart(userId);

    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (cartProducts) => emit(StateFetchedUserCart(cartProducts)),
    );
  }

  Future<void> getUserCartCount(String userId) async {
    emit(const StateCartLoading());
    final result = await _getUserCartCount(userId);

    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (count) => emit(StateFetchedUserCartCount(count)),
    );
  }

  Future<void> getCartProductById(String userId, String cartProductId) async {
    emit(const StateCartLoading());
    final result = await _getCartProductById(
      GetCartProductIdParams(cartProductId: cartProductId, userId: userId),
    );

    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (cartProduct) => emit(StateFetchedCartProduct(cartProduct)),
    );
  }

  Future<void> removeCartProduct(
    String userId,
    String cartProductId,
  ) async {
        final currentCart = state is StateFetchedUserCart 
        ? (state as StateFetchedUserCart).cartProducts 
        : <dynamic>[];
    
    emit(StateCartUpdating(currentCart));

    final result = await _removeProductFromCart(
      RemoveProductQuantityParam(cartProductId: cartProductId, userId: userId),
    );

    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (_) => emit(StateRemovedFromCart()),
    );
  }

  Future<void> updateProductQuantity(
    String userId,
    String cartProductId,
    int quantity,
  ) async {
    // Store current cart items to maintain them during update
    final currentCart = state is StateFetchedUserCart 
        ? (state as StateFetchedUserCart).cartProducts 
        : <dynamic>[];
    
    emit(StateCartUpdating(currentCart));
    
    final result = await _updateProductQuantity(
      UpdateProductQuantityParam(
        cartProductId: cartProductId,
        userId: userId,
        quantity: quantity,
      ),
    );

    result.fold(
      (failure) => emit(StateCartError(failure.errorMessage)),
      (updatedCartProduct) async {
        // After successful update, fetch the updated cart
        final cartResult = await _getUserCart(userId); 

        cartResult.fold(
          (failure) => emit(StateCartError(failure.errorMessage)),
          (cart) {
            // Only emit the updated cart - this will show the cart items
            emit(StateFetchedUserCart(cart));               
          },
        );
      },
    );
  }
}

class QuantityCubit extends Cubit<int> {
  QuantityCubit({
    required int initialQuantity,
  }) : super(initialQuantity);

  void increment() => emit(state + 1);
  void decrement() => emit(state > 1 ? state - 1 : 1);
}