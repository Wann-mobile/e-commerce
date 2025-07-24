import 'dart:convert';

import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/checkout/domain/enitity/transaction_response.dart';

class TransactionResponseModel extends TransactionResponse {
  TransactionResponseModel({required super.checkoutResponseMap});

  TransactionResponseModel copyWith({DataMap? checkoutResponseMap}) {
    return TransactionResponseModel(
     checkoutResponseMap: checkoutResponseMap ?? this.checkoutResponseMap,
    );
  }

  DataMap toMap() {
    return {'checkoutResponseMap': checkoutResponseMap};
  }

  factory TransactionResponseModel.fromMap(DataMap map) {
    return TransactionResponseModel(
      checkoutResponseMap: map ,
    );
  }
  TransactionResponseModel.empty() : this(checkoutResponseMap: {});

  factory TransactionResponseModel.fromJson(String source) =>
      TransactionResponseModel.fromMap(jsonDecode(source));

    String toJson() => jsonEncode(toMap());
}
