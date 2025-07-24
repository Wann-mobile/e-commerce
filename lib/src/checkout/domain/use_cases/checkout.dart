import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/checkout/domain/enitity/transaction_response.dart';

import 'package:e_triad/src/checkout/domain/repos/checkout_repos.dart';
import 'package:equatable/equatable.dart';

class Checkout extends UseCaseWithParams<TransactionResponse, CheckoutParams> {
  Checkout(this._repos);
  final CheckoutRepos _repos;
  @override
  ResultFuture<TransactionResponse> call(CheckoutParams params) => _repos.checkout(
    cartProducts: params.cartProducts,
    city: params.city,
    country: params.country,
    address: params.address,
    phone: params.phone,
  );
}




class CheckoutParams extends Equatable {
  const CheckoutParams({
    required this.cartProducts,
    required this.city,
    required this.country,
    required this.address,
    required this.phone,
  });

  final List<dynamic> cartProducts;
  final String address;
  final String country;
  final String city;
  final String phone;

  @override
  List<Object?> get props => [cartProducts, city, country, address,phone];
}
