import 'dart:convert';

import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSrc {
  const CategoryRemoteDataSrc();

  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel> getCategory(String categoryId);
}

const categoryEndpoint = '/category';

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSrc {
  const CategoryRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$categoryEndpoint');
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
      final payload = jsonDecode(response.body);
      final categories = payload as List<dynamic>;
      final List<CategoryModel> categoryList =
          categories
              .map((category) => CategoryModel.fromMap(category as DataMap))
              .toList();
      return categoryList;
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
  Future<CategoryModel> getCategory(String categoryId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$categoryEndpoint/$categoryId',
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
      final category = CategoryModel.fromMap(payload);
      return category;
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
