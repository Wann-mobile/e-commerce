import 'dart:convert'; // Add this import for json operations
import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/data/models/wishlist_product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSrc {
  const WishlistRemoteDataSrc();

  Future<List<WishlistProductModel>> getUserWishlist(String userId);
  Future<void> addToWishlist({
    required String userId,
    required String productId,
  });
  Future<void> removeWishlist({
    required String userId,
    required String productId,
  });
}

const userEndpoints = '/users';
const wislistEndpoints = '/wishlist';

class WishlistRemoteDataSrcImpl implements WishlistRemoteDataSrc {
  const WishlistRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$userEndpoints/$userId$wislistEndpoints',
      );

      final body = jsonEncode({'productId': productId});
      
      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken!.toAuthPostHeaders,
        body: body,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body) as DataMap;
            final errResponse = ErrorResponse.fromMap(errorData);
            throw ServerException(
              message: errResponse.errMsg,
              statusCode: response.statusCode,
            );
          } catch (e) {
            // If JSON parsing fails, use raw response
            throw ServerException(
              message:
                  response.body.isNotEmpty
                      ? response.body
                      : 'Unknown error occurred',
              statusCode: response.statusCode,
            );
          }
        } else {
          throw ServerException(
            message: 'Failed to add to wishlist',
            statusCode: response.statusCode,
          );
        }
      }
    } on ServerException {
      rethrow;
    } on CacheException {
      throw const ServerException(
        message: 'Session Token has expired',
        statusCode: 401,
      );
    } catch (e, s) {
      debugPrint('Error in addToWishlist: $e');
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server Error Occurred',
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<WishlistProductModel>> getUserWishlist(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$userEndpoints/$userId$wislistEndpoints',
      );
   final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      if (response.statusCode != 200) {
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body) as DataMap;
            final errResponse = ErrorResponse.fromMap(errorData);
            throw ServerException(
              message: errResponse.errMsg,
              statusCode: response.statusCode,
            );
          } catch (e) {
            throw ServerException(
              message:
                  response.body.isNotEmpty
                      ? response.body
                      : 'Unknown error occurred',
              statusCode: response.statusCode,
            );
          }
        } else {
          throw ServerException(
            message: 'Failed to get wishlist',
            statusCode: response.statusCode,
          );
        }
      }

      if (response.body.isEmpty) {
        return <WishlistProductModel>[];
      }

      final List<dynamic> responseData =
          jsonDecode(response.body) as List<dynamic>;

      final List<WishlistProductModel> wishlistProducts =
          responseData
              .map(
                (wishlistItem) =>
                    WishlistProductModel.fromMap(wishlistItem as DataMap),
              )
              .toList();

      return wishlistProducts;
    } on ServerException {
      rethrow;
    } on CacheException {
      throw const ServerException(
        message: 'Session Token has expired',
        statusCode: 401,
      );
    } catch (e, s) {
      debugPrint('Error in getUserWishlist: $e');
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server Error Occurred',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> removeWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$userEndpoints/$userId$wislistEndpoints/$productId',
      );
      final body = jsonEncode({'productId': productId});
      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken!.toAuthPostHeaders,
        body: body
      );
      if (response.statusCode != 200 &&
          response.statusCode != 204 &&
          response.statusCode != 202) {
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body) as DataMap;
            final errResponse = ErrorResponse.fromMap(errorData);
            throw ServerException(
              message: errResponse.errMsg,
              statusCode: response.statusCode,
            );
          } catch (e) {
            throw ServerException(
              message:
                  response.body.isNotEmpty
                      ? response.body
                      : 'Unknown error occurred',
              statusCode: response.statusCode,
            );
          }
        } else {
          throw ServerException(
            message: 'Failed to remove from wishlist',
            statusCode: response.statusCode,
          );
        }
      }
    } on ServerException {
      rethrow;
    } on CacheException {
      throw const ServerException(
        message: 'Session Token has expired',
        statusCode: 401,
      );
    } catch (e, s) {
      debugPrint('Error in removeWishlist: $e');
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server Error Occurred',
        statusCode: 500,
      );
    }
  }
}
