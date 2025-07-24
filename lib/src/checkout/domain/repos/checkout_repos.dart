import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/checkout/domain/enitity/transaction_response.dart';



abstract class CheckoutRepos {
  ResultFuture<TransactionResponse> checkout({
     required List<dynamic> cartProducts,
    required String city,
    required String country,
    required String address,
    required String phone,
  });
}