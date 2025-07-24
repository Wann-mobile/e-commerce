import 'dart:convert';

import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/data/model/reviews_model.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ReviewRemoteDataSrc {
  const ReviewRemoteDataSrc();

  Future<List<Reviews>> getProductReviews(String productId, {int page = 1});

  Future<DataMap> createReview({
    required String productId,
    required String userId,
    required String reviewContent,
    required double rating,
  });
}
const productsEndpoint = '/products';
const reviewsEndpoint = '/reviews';

class ReviewRemoteDataScrImpl implements ReviewRemoteDataSrc {
  const ReviewRemoteDataScrImpl(this._client);

  final http.Client _client;
  
  @override
  Future<DataMap> createReview({
    required String productId,
    required String userId,
    required String reviewContent,
    required double rating,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/$productId$reviewsEndpoint',
      );
      final response = await _client.post(
        uri,
        body: jsonEncode({
          'userId': userId,
          'reviewContent': reviewContent,
          'rating': rating,
        }),
      );
      if (response.statusCode != 201 || response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      final payload = jsonDecode(response.body) as DataMap;
      return payload;
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
  Future<List<ReviewsModel>> getProductReviews(
    String productId, {
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/$productId$reviewsEndpoint?page=$page',
      );
      final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      final payload = jsonDecode(response.body) as List<dynamic>;
      final reviews = payload ;
      final List<ReviewsModel> reviewList =
          reviews
              .map((review) => ReviewsModel.fromMap(review as DataMap))
              .toList();
              
      return reviewList;
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
