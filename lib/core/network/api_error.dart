class ApiError {
  final String message;
  final int? statusCode;
  final dynamic error;

  ApiError({
    required this.message,
    this.statusCode,
    this.error,
  });

  factory ApiError.fromHttpError(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiError(message: 'Bad Request', statusCode: statusCode);
      case 401:
        return ApiError(message: 'Unauthorized', statusCode: statusCode);
      case 403:
        return ApiError(message: 'Forbidden', statusCode: statusCode);
      case 404:
        return ApiError(message: 'Not Found', statusCode: statusCode);
      case 408:
        return ApiError(message: 'Request Timeout', statusCode: statusCode);
      case 500:
        return ApiError(
            message: 'Internal Server Error', statusCode: statusCode);
      case 502:
        return ApiError(message: 'Bad Gateway', statusCode: statusCode);
      case 503:
        return ApiError(message: 'Service Unavailable', statusCode: statusCode);
      default:
        return ApiError(
            message: 'Something went wrong', statusCode: statusCode);
    }
  }

  factory ApiError.network() {
    return ApiError(message: 'No Internet Connection');
  }

  factory ApiError.timeout() {
    return ApiError(message: 'Request Timeout');
  }

  factory ApiError.unknown() {
    return ApiError(message: 'Unknown Error Occurred');
  }

  @override
  String toString() => message;
}