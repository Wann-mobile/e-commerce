import 'dart:convert';

import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/common/user_related_models/user_model.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/core/utils/error_response.dart';
import 'package:e_triad/core/utils/network_utilities/network_utils.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });
  Future<UserModel> login({required String email, required String password});
  Future<void> forgotPassword({required String email});
  Future<void> verifyOtp({required String email, required String otp});
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<bool> verifyToken();
}

const registerEndpoint = '/register';
const loginEndpoint = '/login';
const resetPasswordEndpoint = '/reset-password';
const forgotPasswordEndpoint = '/forgot-password';
const verifyOtpEndpoint = '/verify-OTP';
const verifyTokenEndpoint = '/verify-token';

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$forgotPasswordEndpoint',
      );

      final response = await _client.post(
        uri,
        body: jsonEncode({'email': email}),
        headers: NetworkConstants.header,
      );
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$loginEndpoint');

      final response = await _client.post(
        uri,
        body: jsonEncode({'email': email, 'password': password}),
        headers: NetworkConstants.header,
      );
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
      await sl<CacheHelper>().cacheSessionToken(payload['accessToken']);
      final user = UserModel.fromMap(payload);
      await sl<CacheHelper>().cacheUserId(user.id);
      return user;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$registerEndpoint');

      final response = await _client.post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }),
        headers: NetworkConstants.header,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$resetPasswordEndpoint',
      );

      final response = await _client.post(
        uri,
        body: jsonEncode({'email': email, 'newPassword': newPassword}),
        headers: NetworkConstants.header,
        
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$verifyOtpEndpoint');

      final response = await _client.post(
        uri,
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: NetworkConstants.header,
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Server Error Occured', statusCode: 500);
    }
  }

  @override
Future<bool> verifyToken() async {
  try {
    final uri = Uri.parse('${NetworkConstants.baseUrl}$verifyTokenEndpoint');
    
    final response = await _client.get(
      uri,
      headers: sl<CacheHelper>().getSessionToken()!.toAuthHeaders
    );
    
    
    if (response.statusCode != 200) {
      
      try {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errMsg,
          statusCode: response.statusCode,
        );
      } catch (jsonError) {
        debugPrint('Non-JSON error response: ${response.body}');
        throw ServerException(
          message: 'Server returned error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    }
    
    final payload = jsonDecode(response.body);
    await NetworkUtils.renewToken(response);
    
        return payload as bool;
    
  } on ServerException {
    rethrow;
  } catch (e, s) {
    debugPrint('Error details: $e');
    debugPrintStack(stackTrace: s);
    throw ServerException(message: 'Server Error Occurred', statusCode: 500);
  }
}
}
