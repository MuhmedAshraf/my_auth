abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(
    String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> patch(
    String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> delete(
    String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  });
}
