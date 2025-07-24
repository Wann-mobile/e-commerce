import 'dart:convert';

import 'package:e_triad/core/common/user_related_models/user_model.dart';
import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  });
  
}

const userEndpoint = '/users';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$userEndpoint/$userId');

      final response =  await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;

      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  
  @override
  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$userEndpoint/$userId');

      final response = await _client.put(
        uri,
        body: jsonEncode(updateData),
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;

      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }
}
