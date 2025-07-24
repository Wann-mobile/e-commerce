import 'dart:convert';
import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/data/models/cart_product_model.dart';
import 'package:e_triad/src/checkout/data/models/transaction_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http show Client;

abstract class CheckoutDataSrc {
  const CheckoutDataSrc();

  Future<TransactionResponseModel> checkout({
    required List<dynamic> cartProducts,
    required String city,
    required String country,
    required String address,
    required String phone,
  });
}

class CheckoutDataSrcImpl implements CheckoutDataSrc {
  const CheckoutDataSrcImpl(this._client);
  final http.Client _client;
  @override
  Future<TransactionResponseModel> checkout({
    required List<dynamic> cartProducts,
    required String city,
    required String country,
    required String address,
    required String phone,
  }) async {
    final uri = Uri.parse('${NetworkConstants.baseUrl}/checkout/');
 
   final cartProductMaps = cartProducts.map((product) {
    if (product is CartProductModel) {
      return {
        '_id': product.id,                        
        'product': product.product,               
        'quantity': product.quantity,
        'selectedSize': product.selectedSize,
        'productName': product.productName,
        'productImage': product.productImage,
        'productPrice': product.productPrice ,     
        'productExists': product.productExists,   
        'productOutOfStock': product.productOutOfStock,
        'reserved': product.isReserved,
        'reservationExpiry': product.reservationExpiryDate,
        'checkoutPending': product.checkoutPending,
      };
    }
    return product;
  }).toList();

    final body = jsonEncode({
      'cartItems': cartProductMaps,
      'city': city,
      'country': country,
      'shippingAddress': address,
      'phone': phone,
    });
    final response = await _client.post(
      uri,
      body: body,
      headers: Cache.instance.sessionToken!.toAuthPostHeaders,
    );
    final decodedResponse = jsonDecode(response.body);
    debugPrint('checkout response: $decodedResponse');
    if (response.statusCode != 201) {
      // Handle error response
      if (decodedResponse is DataMap) {
        throw ServerException(
          message: decodedResponse['error']?.toString() ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      } else if (decodedResponse is String) {
        // Handle string error response

        throw ServerException(
          message: decodedResponse,
          statusCode: response.statusCode,
        );
      } else {
        // Handle unexpected response type
        throw ServerException(
          message: 'Unexpected error response format',
          statusCode: response.statusCode,
        );
      }
    }

    // Handle success response
    if (decodedResponse is! Map<String, dynamic>) {
      throw ServerException(
        message: 'Invalid response format',
        statusCode: response.statusCode,
      );
    }
    final payload = decodedResponse;

    final checkoutResult = TransactionResponseModel.fromMap(payload);

    return checkoutResult;
  }
}
