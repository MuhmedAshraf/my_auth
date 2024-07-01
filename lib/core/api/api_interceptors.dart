import 'package:my_auth/cach/cache_helper.dart';
import 'package:my_auth/core/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKeys.token] =
        CacheHelper().getData(key: ApiKeys.token) != null
            ? 'FOODAPI ${CacheHelper().getData(key: ApiKeys.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
