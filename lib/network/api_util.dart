import 'package:dio/dio.dart';
import 'package:newwave_solution_flutter_test/utils/constants.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  final Dio _dio = Dio();

  String apiKey = Constants.API_KEY;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    // _dio.options.baseUrl = Constants.BASE_URL;
    _dio.options.connectTimeout = const Duration(seconds: 5000); // 5 giây
    _dio.options.receiveTimeout = const Duration(seconds: 3000); // 3 giây
    _dio.options.persistentConnection = true;

// Thêm Interceptor để thêm Bearer Token vào mỗi yêu cầu
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Thêm Bearer token vào tiêu đề
        //if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $apiKey';
        // }
        return handler.next(options); // Tiếp tục với yêu cầu
      },
      onResponse: (response, handler) {
        return handler.next(response); // Tiếp tục với phản hồi
      },
      onError: (DioException e, handler) {
        return handler.next(e); // Tiếp tục với lỗi
      },
    ));
  }


  void clear() {
    _dio.options = BaseOptions(); // Reset options to default
    _dio.interceptors.clear(); // Clear all interceptors
    apiKey = ""; // Clear the token
  }

  Dio get dio => _dio;
}
