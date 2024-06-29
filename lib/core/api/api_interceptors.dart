import 'package:my_auth/core/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    super.onRequest(options, handler);
  }

}