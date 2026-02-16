import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;


class DioService extends GetxService {
  // Initialize directly - no late keyword
  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  DioService() {
    // Add interceptors after initialization
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🌐 REQUEST: ${options.method} ${options.uri}');
          print('📤 DATA: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ RESPONSE: ${response.statusCode}');
          print('📥 DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ ERROR: ${error.message}');
          print('📛 STATUS: ${error.response?.statusCode}');
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<dio.Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<dio.Response> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<dio.Response> put(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<dio.Response> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return response;
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  String _handleError(dio.DioException error) {
    String errorMessage = 'Something went wrong';

    if (error.response != null) {
      // Server responded with error
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      if (data is Map && data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (statusCode == 404) {
        errorMessage = 'Resource not found';
      } else if (statusCode == 500) {
        errorMessage = 'Server error. Please try again later';
      } else {
        errorMessage = 'Error: ${error.response!.statusMessage}';
      }
    } else {
      // Network error
      switch (error.type) {
        case dio.DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout. Please check your internet';
          break;
        case dio.DioExceptionType.sendTimeout:
          errorMessage = 'Send timeout. Please try again';
          break;
        case dio.DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout. Please try again';
          break;
        case dio.DioExceptionType.connectionError:
          errorMessage = 'No internet connection';
          break;
        case dio.DioExceptionType.cancel:
          errorMessage = 'Request cancelled';
          break;
        default:
          errorMessage = 'Network error: ${error.message}';
      }
    }

    // Show snackbar
    Get.snackbar(
      'Error',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
    );

    return errorMessage;
  }
}