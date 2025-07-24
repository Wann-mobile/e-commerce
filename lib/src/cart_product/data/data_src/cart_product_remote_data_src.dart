import 'dart:convert';

import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/data/models/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CartProductRemoteDataSrc {
  const CartProductRemoteDataSrc();

  Future<List<CartProductModel>> getUserCart(String userId);
  Future<int> getUserCartCount(String userId);
  Future<CartProductModel> getCartProductById(
    String cartProductId,
    String userId,
  );
  Future<void> addToCart(
    String productId,
    String userId,
    int? quantity,
    String selectedSize,
  );
  Future<CartProductModel> updateProductQuantity(
    String cartProductId,
    String userId,
    int quantity,
  );
  Future<void> removeProductFromCart(String cartProductId, String userId);
}

const usersEndpoint = '/users';
const cartEndpoint = '/cart';

class CartProductRemoteDataSrcImpl implements CartProductRemoteDataSrc {
  const CartProductRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> addToCart(
    String productId,
    String userId,
    int? quantity,
    String selectedSize,
  ) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint',
      );

      final body = jsonEncode({
        'productId': productId,
        'quantity': quantity,
        'selectedSize': selectedSize,
      });
      
      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken!.toAuthPostHeaders,
        body: body,
      );
      if (response.statusCode != 201) {
        final payload = response.body;
        
        throw {
          ServerException(
            message: '$payload error occured',
            statusCode: response.statusCode,
          ),
        };
      }
     
    } on ServerException {
      rethrow;
    } on CacheException {
      throw ErrorResponse(
        message: 'Session Token has expired, kindly login again',
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<CartProductModel> getCartProductById(
    String cartProductId,
    String userId,
  ) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint/$cartProductId',
      );
      final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errResponse = ErrorResponse.fromMap(payload);
        throw {
          ServerException(
            message: errResponse.errMsg,
            statusCode: response.statusCode,
          ),
        };
      }

      final cartProduct = CartProductModel.fromMap(payload);

      return cartProduct;
    } on ServerException {
      rethrow;
    } on CacheException {
      throw ErrorResponse(
        message: 'Session Token has expired, kindly login again',
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<List<CartProductModel>> getUserCart(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint',
      );
      final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body) as List<dynamic> ;

      if (response.statusCode != 200) {
        final errResponse = 
         ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      final responseData = payload ;
      final cartProductList =
          responseData
              .map(
                (cartProduct) =>
                    CartProductModel.fromMap(cartProduct as DataMap),
              )
              .toList();

      return cartProductList;
    } on ServerException {
      rethrow;
    } on CacheException {
      throw ErrorResponse(
        message: 'Session Token has expired, kindly login again',
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<int> getUserCartCount(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint/count',
      );
      final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body) as DataMap;

      if (response.statusCode != 200) {
        final errResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errResponse.errMsg,
          statusCode: response.statusCode,
        );
      }

      final int cartCount = payload as int;
      return cartCount;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<void> removeProductFromCart(
    String cartProductId,
    String userId,
  ) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint/$cartProductId',
      );

      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      if (response.statusCode != 204) {
        final payload = response.body as DataMap;
        final errResponse = ErrorResponse.fromMap(payload);
        throw {
          ServerException(
            message: errResponse.errMsg,
            statusCode: response.statusCode,
          ),
        };
      }
    } on ServerException {
      rethrow;
    } on CacheException {
      throw ErrorResponse(
        message: 'Session Token has expired, kindly login again',
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<CartProductModel> updateProductQuantity(
    String cartProductId,
    String userId,
    int quantity,
  ) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$usersEndpoint/$userId$cartEndpoint/$cartProductId',
      );
      final body = jsonEncode({'quantity' : quantity});
      final response = await _client.put(
        uri,
        headers: Cache.instance.sessionToken!.toAuthPostHeaders,
        body: body
      );
      final payload = response.body;
      if (response.statusCode != 200) {
        final errResponse = ErrorResponse.fromMap(payload as DataMap);
        throw {
          ServerException(
            message: errResponse.errMsg,
            statusCode: response.statusCode,
          ),
        };
      }

      final cartProduct = CartProductModel.fromJson(payload);
      return cartProduct;
    } on ServerException {
      rethrow;
    } on CacheException {
      throw ErrorResponse(
        message: 'Session Token has expired, kindly login again',
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }
}
