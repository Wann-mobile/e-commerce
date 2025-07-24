part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class StateCartLoading extends CartState {
  const StateCartLoading();
}

class StateCartUpdating extends CartState {
  const StateCartUpdating(this.cartProducts);
  
  final List<dynamic> cartProducts;
  
  @override
  List<Object> get props => [cartProducts];
}

final class StateAddedToCart extends CartState {
  const StateAddedToCart();

}

final class StateRemovedFromCart extends CartState {
  const StateRemovedFromCart();
}

final class StateUpdatedQuantity extends CartState {
  const StateUpdatedQuantity(this.cartProduct);

  final CartProduct cartProduct;

  @override
  List<Object?> get props => [cartProduct];
}

final class StateFetchedUserCart extends CartState {
  const StateFetchedUserCart(this.cartProducts);

  final List<CartProduct> cartProducts;

  @override
  List<Object?> get props => [cartProducts];
}

final class StateFetchedUserCartCount extends CartState {
  const StateFetchedUserCartCount(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

final class StateFetchedCartProduct extends CartState {
  const StateFetchedCartProduct(this.cartProduct);

  final CartProduct cartProduct;

  @override
  List<Object?> get props => [cartProduct];
}

final class StateCartError extends CartState {
  const StateCartError(this.message);

  final String message;
  @override
  List<Object?> get props => [message];
}
