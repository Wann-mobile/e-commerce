import 'dart:async';
import 'dart:io';

import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/services/router_import.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

abstract class NetworkUtils {
  const NetworkUtils();

  static Future<void> renewToken(http.Response response) async {
    if (response.headers['authorization'] != null) {
      var token = response.headers['authorization'] as String;
      if (token.startsWith('Bearer ')) {
        token = token.replaceFirst('Bearer ', '').trim();
      }
      await sl<CacheHelper>().cacheSessionToken(token);
    } else if (response.statusCode == 401) {
      rootNavigatorKey.currentContext?.go('/');
    }
  }

  static const Duration _requestTimeout = Duration(seconds: 30);
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

 static Future<http.Response> makeRequest(
    Uri uri, {
    Map<String, String>? headers,
    required http.Client client,
    int retryCount = 0,
  }) async {
    try {
          final response = await client
          .get(uri, headers: headers)
          .timeout(_requestTimeout);

          return response;
    } on TimeoutException catch (e) {
      debugPrint('Request timeout: $e');
      if (retryCount < _maxRetries) {
        await Future.delayed(_retryDelay * (retryCount + 1));
        return makeRequest(
          uri,
          headers: headers,
          retryCount: retryCount + 1,
          client: client,
        );
      }
      throw ServerException(
        message: 'Request timeout after ${_maxRetries + 1} attempts',
        statusCode: 408,
      );
    } on SocketException catch (e) {
      debugPrint('Socket error: $e');
      if (retryCount < _maxRetries) {
        await Future.delayed(_retryDelay * (retryCount + 1));
        return makeRequest(
          uri,
          headers: headers,
          retryCount: retryCount + 1,
          client: client,
        );
      }
      throw ServerException(
        message: 'Network connection error: ${e.message}',
        statusCode: 500,
      );
    } on HttpException catch (e) {
      debugPrint('HTTP error: $e');
      if (retryCount < _maxRetries && _shouldRetryHttpError(e)) {
        await Future.delayed(_retryDelay * (retryCount + 1));
        return makeRequest(
          uri,
          headers: headers,
          retryCount: retryCount + 1,
          client: client,
        );
      }
      throw ServerException(
        message: 'HTTP error: ${e.message}',
        statusCode: 500,
      );
    } on http.ClientException catch (e) {
      debugPrint('Client exception: $e');
      if (retryCount < _maxRetries && _shouldRetryClientError(e)) {
        await Future.delayed(_retryDelay * (retryCount + 1));
        return makeRequest(
          uri,
          headers: headers,
          retryCount: retryCount + 1,
          client: client,
        );
      }
      throw ServerException(
        message: 'Connection error: ${e.message}',
        statusCode: 500,
      );
    } catch (e) {
      debugPrint('Unexpected error: $e');
      if (retryCount < _maxRetries) {
        await Future.delayed(_retryDelay * (retryCount + 1));
        return makeRequest(
          uri,
          headers: headers,
          retryCount: retryCount + 1,
          client: client,
        );
      }
      throw ServerException(message: 'Unexpected error: $e', statusCode: 500);
    }
  }

 static bool _shouldRetryHttpError(HttpException e) {
    return e.message.contains('Connection closed') ||
        e.message.contains('Connection reset') ||
        e.message.contains('Connection refused');
  }

  static bool _shouldRetryClientError(http.ClientException e) {
    return e.message.contains('Connection closed') ||
        e.message.contains('Connection reset') ||
        e.message.contains('XMLHttpRequest error') ||
        e.message.contains('Network is unreachable');
  }

  // Enhanced response processing
 
}
