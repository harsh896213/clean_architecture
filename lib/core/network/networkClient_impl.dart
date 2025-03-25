import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/network_client.dart';

class NetworkClientImpl implements NetworkClient {
  final Dio _dio;
  final CancelToken _cancelToken = CancelToken();
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 1);

  NetworkClientImpl(this._dio){
    _setupSSLPinning();
  }

  void _setupSSLPinning() async {
    //ensures that the validation is performed only against the loaded certificates.
    final SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    // Load your server certificate into the SecurityContext
    try {
      // final sslCert = await rootBundle.load('assets/certificates/my_cert.pem');
      // securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
    } catch (e) {
      throw Exception("Failed to load SSL certificate: $e");
    }

    // Configure Dio to use the custom HttpClientAdapter with SSL pinning
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      return HttpClient(context: securityContext)
        ..badCertificateCallback = (X509Certificate cert, String host, int port) {
          return false;
        };
    };
  }


  Future<Either<ApiError, T>> _executeWithRetry<T>(
    Future<Either<ApiError, T>> Function() apiCall,
  ) async {
    int retryCount = 0;
    while (retryCount < _maxRetries) {
      try {
        final result = await apiCall();
        return result;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          return Left(ApiError(message: 'Request cancelled'));
        }

        retryCount++;
        if (retryCount == _maxRetries) {
          return Left(ApiError(message: e.message ?? ""));
        }

        await Future.delayed(_retryDelay * retryCount);
      }
    }
    return Left(ApiError(message: 'Max retries exceeded'));
  }

  @override
  Future<Either<ApiError, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _executeWithRetry(() async {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );

      if (fromJson != null) {
        return Right(fromJson(response.data));
      }
      return Right(response.data as T);
    });
  }

  @override
  Future<Either<ApiError, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _executeWithRetry(() async {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );

      if (fromJson != null) {
        return Right(fromJson(response.data));
      }
      return Right(response.data as T);
    });
  }

  @override
  Future<Either<ApiError, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _executeWithRetry(() async {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );

      if (fromJson != null) {
        return Right(fromJson(response.data));
      }
      return Right(response.data as T);
    });
  }

  @override
  Future<Either<ApiError, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _executeWithRetry(() async {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );

      if (fromJson != null) {
        return Right(fromJson(response.data));
      }
      return Right(response.data as T);
    });
  }

  @override
  Future<Either<ApiError, T>> uploadFile<T>(
    String path,
    File file, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _executeWithRetry(() async {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
        if (data != null) ...data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );

      if (fromJson != null) {
        return Right(fromJson(response.data));
      }
      return Right(response.data as T);
    });
  }

  void cancelRequests() {
    _cancelToken.cancel('Request cancelled by user');
  }
}
