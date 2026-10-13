import 'package:dio/dio.dart';

import 'failures.dart';

Failure mapExceptionToFailure(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timed out. Please try again.');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection.');
      case DioExceptionType.badResponse:
        return ServerFailure(_messageFromResponse(error.response));
      default:
        return const ServerFailure('Something went wrong. Please try again.');
    }
  }
  return const UnexpectedFailure('Something went wrong. Please try again.');
}

String _messageFromResponse(Response<dynamic>? response) {
  final status = response?.statusCode;
  if (status == 401) return 'Invalid email or password.';

  final data = response?.data;
  if (data is Map && data['message'] != null) {
    final message = data['message'];
    if (message is List) return message.join('\n');
    return message.toString();
  }
  return 'Server error${status != null ? ' ($status)' : ''}. Please try again.';
}
