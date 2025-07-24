import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/checkout/data/data_src/checkout_data_src.dart';
import 'package:e_triad/src/checkout/domain/enitity/transaction_response.dart';
import 'package:e_triad/src/checkout/domain/repos/checkout_repos.dart';


class CheckoutRepoImpl implements CheckoutRepos {
  const CheckoutRepoImpl(this._dataSrc);

  final CheckoutDataSrc _dataSrc;

  @override
  ResultFuture<TransactionResponse> checkout({
    required List<dynamic> cartProducts,
    required String city,
    required String country,
    required String address,
    required String phone,
  }) async {
    try {
    final results=  await _dataSrc.checkout(
        cartProducts: cartProducts,
        city: city,
        country: country,
        address: address,
        phone: phone,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
