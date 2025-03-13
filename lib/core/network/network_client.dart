import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';

/// Custom error class to handle API errors


abstract interface class NetworkClient {
  Future<Either<ApiError, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<Either<ApiError, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<Either<ApiError, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<Either<ApiError, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<Either<ApiError, T>> uploadFile<T>(
    String path,
    File file, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });
}
