import 'dart:convert';

import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http show Client;

abstract class ProductRemoteDataSrc {
  const ProductRemoteDataSrc();

  Future<ProductModel> getProduct(String productId);

  Future<List<ProductModel>> getAllProducts({int page = 1});

  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int page = 1,
  });

  Future<List<ProductModel>> getNewArrivalProducts({int page = 1});

  Future<List<ProductModel>> getPopularProducts({int page = 1});

  Future<List<ProductModel>> searchAllProducts({
    required String searchTerm,
    int page = 1,
  });

  Future<List<ProductModel>> searchProductsByCategory({
    required String searchTerm,
    required String category,
    int page = 1,
  });

  Future<List<ProductModel>> searchProductsByGenderAgeCategory({
    required String searchTerm,
    required String genderAgeCategory,
    int page = 1,
  });
}

const productsEndpoint = '/products';

class ProductRemoteDataSrcImpl implements ProductRemoteDataSrc {
  const ProductRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<ProductModel>> getAllProducts({int page = 1}) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint?page=$page',
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
      final payload = jsonDecode(response.body) as DataMap;

      final products = payload['products'] as List<dynamic>;

      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();
      return productList;
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
  Future<List<ProductModel>> getNewArrivalProducts({int page = 1}) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint?criteria=arrivals',
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
      final payload = jsonDecode(response.body) as DataMap;
      final products = payload['products'] as List<dynamic>;
      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();
      return productList;
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
  Future<List<ProductModel>> getPopularProducts({int page = 1}) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/?criteria=popular',
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
      final payload = jsonDecode(response.body) as DataMap;
      final products = payload['products'] as List<dynamic>;
      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();

      return productList;
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
  Future<ProductModel> getProduct(String productId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/$productId',
      );
      final response = await NetworkUtils.makeRequest(
        uri,
        client: _client,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      final payload = jsonDecode(response.body) as DataMap;
      final product = ProductModel.fromMap(payload);

      return product;
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
  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/?category=$category&page=$page',
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
      final payload = jsonDecode(response.body) as DataMap;
      final products = payload['products'] as List<dynamic>;
      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();
      return productList;
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
  Future<List<ProductModel>> searchAllProducts({
    required String searchTerm,
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/search?q=$searchTerm&page=$page',
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
      final payload = jsonDecode(response.body) as DataMap;
      final searchResultsData = payload['searchResults'] as List<dynamic>;
      final List<ProductModel> productList =
          searchResultsData.map((productData) {
            debugPrint('Searched product: ${productData['name']}');
            return ProductModel.fromMap(productData as DataMap);
          }).toList();
      return productList;
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
  Future<List<ProductModel>> searchProductsByCategory({
    required String searchTerm,
    required String category,
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/search?q=$searchTerm&category=$category&page=$page',
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
      final payload = jsonDecode(response.body) as DataMap;
      final products = payload as List<dynamic>;
      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();
      return productList;
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
  Future<List<ProductModel>> searchProductsByGenderAgeCategory({
    required String searchTerm,
    required String genderAgeCategory,
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$productsEndpoint/search?q=$searchTerm&genderAgeCategory=$genderAgeCategory&page=$page',
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
      final payload = jsonDecode(response.body) as DataMap;
      final products = payload as List<dynamic>;
      final List<ProductModel> productList =
          products
              .map((product) => ProductModel.fromMap(product as DataMap))
              .toList();
      return productList;
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
