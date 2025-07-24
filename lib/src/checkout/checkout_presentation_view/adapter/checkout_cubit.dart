import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/checkout/domain/use_cases/checkout.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required Checkout checkout})
    : _checkout = checkout,
      super(const StateCheckoutInitial());

  final Checkout _checkout;

  Future<void> startCheckingOut({
    required List<dynamic> cartProducts,
    required String city,
    required String country,
    required String address,
    required String phone,
  }) async {
    emit(const StateCheckoutLoading());
    final result = await _checkout(
      CheckoutParams(
        cartProducts: cartProducts,
        city: city,
        country: country,
        address: address,
         phone: phone,
      ),
    );
    result.fold(
      (failure) => emit(StateCheckoutError(failure.errorMessage)),
      (response) =>
          emit(StateCheckoutSuccessful(response.checkoutResponseMap)),
    );
  }
}
