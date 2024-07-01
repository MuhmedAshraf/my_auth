import 'package:my_auth/core/api/api_consumer.dart';
import 'package:dio/dio.dart';
import 'package:my_auth/core/api/api_interceptors.dart';
import 'package:my_auth/core/api/end_points.dart';

import '../errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}){
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }


  @override
  Future delete(String path,
      {data,
      bool isFormData = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(String path,
      {data,
      bool isFormData = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {data,
      bool isFormData = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
