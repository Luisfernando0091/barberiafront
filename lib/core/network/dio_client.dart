import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../storage/local_storage.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await LocalStorage.getToken();

              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }

              return handler.next(options);
            },
          ),
        );
}
