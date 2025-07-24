part of 'checkout_cubit.dart';

sealed class CheckoutState  extends Equatable {
  const CheckoutState();
 
 @override
  List<Object?> get props => [];
}
final class StateCheckoutInitial extends CheckoutState {
  const StateCheckoutInitial();
}
final class StateCheckoutLoading extends CheckoutState{
  const StateCheckoutLoading();
}

final class StateCheckoutSuccessful extends CheckoutState{
  const StateCheckoutSuccessful(this.transactionResponse);

final DataMap transactionResponse;

  @override
  List<Object?> get props => [transactionResponse];
}

final class StateCheckoutError extends CheckoutState{
  const StateCheckoutError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}