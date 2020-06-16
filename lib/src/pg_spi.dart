import 'package:dio/dio.dart';
import 'pg_spi_error.dart';
import 'pg_spi_logger.dart';
import 'pg_spi_manager.dart';
import 'pg_spi_response.dart';
import 'pg_spi_target.dart';
import 'pg_spi_dio.dart';

class PGSpi {
  PGSpiTarget target;
  PGDio _dio;

  PGSpi(PGSpiTarget target) {
    this.target = target;
    _http();
  }
  void _http() {
    // 初始化 Options
    _dio = PGDio(
      BaseOptions(
        sendTimeout: PGSpiManager.shared.config.connectTimeout,
        receiveTimeout: PGSpiManager.shared.config.receiveTimeout,
        headers: target.headers,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    _dio.interceptors.add(LogsInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }
}

// response
extension PGSpiEx on PGSpi {
  // 返回JSON
  Future<Map<String, dynamic>> responseJson<T>({
    onReceiveProgress,
  }) async {
    try {
      Map<String, dynamic> response = await _dio.mapJson(
        target,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      print('错误信息：' + (e.error as PGSpiError).message);
      throw e;
    }
  }

  // 过滤返回结果(只包含状态字段) Map<String, dynamic>
  Future<Map<String, dynamic>> responseSpiJson<T>({
    String path,
    onReceiveProgress,
  }) async {
    try {
      dynamic response = await _dio.mapSpiJson(
        target,
        designatedPath: path,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }

  // 过滤返回结果(只包含状态字段) List<Map<String, dynamic>>
  Future<List<Map<String, dynamic>>> responseSpiJsons<T>({
    String path,
    onReceiveProgress,
  }) async {
    try {
      List<dynamic> response = await _dio.mapSpiJsons(
        target,
        designatedPath: path,
        onReceiveProgress: onReceiveProgress,
      );
      return response
          .map(
            (e) => Map<String, dynamic>.from(e),
          )
          .toList();
    } on DioError catch (e) {
      throw e;
    }
  }
}
