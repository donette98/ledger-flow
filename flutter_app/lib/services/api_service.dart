import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;
  late Logger logger;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://api.ledgerflow.app', // Replace with actual API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(baseOptions);
    logger = Logger();

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.d('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d('Response: ${response.statusCode} ${response.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          logger.e('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      logger.e('GET error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } catch (e) {
      logger.e('POST error: $e');
      rethrow;
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } catch (e) {
      logger.e('PUT error: $e');
      rethrow;
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } catch (e) {
      logger.e('DELETE error: $e');
      rethrow;
    }
  }
}
