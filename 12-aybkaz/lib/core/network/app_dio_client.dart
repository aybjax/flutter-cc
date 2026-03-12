import 'package:dio/dio.dart';

class AppDioClient {
  AppDioClient()
    : _dio =
          Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
                sendTimeout: const Duration(seconds: 5),
                headers: const {'Accept': '*/*'},
              ),
            )
            ..interceptors.add(
              LogInterceptor(
                requestBody: false,
                responseBody: false,
                requestHeader: false,
                responseHeader: false,
              ),
            );

  final Dio _dio;

  Future<bool> probeServer(String httpUrl) async {
    final response = await _dio.getUri<dynamic>(
      Uri.parse(httpUrl),
      options: Options(
        responseType: ResponseType.plain,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    final statusCode = response.statusCode ?? 500;
    return statusCode >= 200 && statusCode < 500;
  }
}
