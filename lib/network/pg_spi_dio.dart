import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'pg_spi_error.dart';
import 'pg_spi_manager.dart';
import 'pg_spi_target.dart';

class PGDio extends DioForNative {
  PGDio(BaseOptions options) : super(options);

  // 请求
  Future<Map<String, dynamic>> mapJson<T>(
    PGSpiTarget target, {
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    onReceiveProgress,
  }) async {
    try {
      Response response = await request(
        target.baseUrl + target.path,
        data: target.method == HTTPMethod.get ? {} : target.parameters,
        options: checkOptions(target.method.value, options),
        queryParameters:
            target.method != HTTPMethod.get ? {} : target.parameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError {
      throw DioError(
        error: PGSpiError.exception(Exception.unacceptableStatusCode),
      );
    }
  }

  // 返回结果为 Map
  Future<Map<String, dynamic>> mapSpiJson<T>(
    PGSpiTarget target, {
    String designatedPath,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    onReceiveProgress,
  }) async {
    try {
      Response response = await request(
        target.baseUrl + target.path,
        data: target.method == HTTPMethod.get ? {} : target.parameters,
        options: checkOptions(target.method.value, options),
        queryParameters:
            target.method != HTTPMethod.get ? {} : target.parameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      var json = response.data;
      var status = json[PGSpiManager.shared.key.status];
      if (status == PGSpiManager.shared.key.success) {
        if (json[PGSpiManager.shared.key.data] == null) {
          return {};
        }
        if (designatedPath == null || designatedPath.length <= 0) {
          return json[PGSpiManager.shared.key.data];
        }
        if (json[PGSpiManager.shared.key.data][designatedPath] == null) {
          throw DioError(
            error: PGSpiError.exception(Exception.objectFailed),
          );
        }
        return json[PGSpiManager.shared.key.data][designatedPath];
      } else {
        if (status != null && status is int) {
          // 请求正常，操作失败
          throw DioError(
            error: PGSpiError.exception(
              Exception.executeFail,
              status: status,
              message: json[PGSpiManager.shared.key.msg],
            ),
          );
        }
        // 请求结果状态码不合法
        throw DioError(
          error: PGSpiError.exception(Exception.unlegal),
        );
      }
    } on DioError {
      throw DioError(
        error: PGSpiError.exception(Exception.unacceptableStatusCode),
      );
    }
  }

  // 返回结果为 List
  Future<List<dynamic>> mapSpiJsons<T>(
    PGSpiTarget target, {
    String designatedPath,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    onReceiveProgress,
  }) async {
    try {
      Response response = await request(
        target.baseUrl + target.path,
        data: target.method == HTTPMethod.get ? {} : target.parameters,
        options: checkOptions(target.method.value, options),
        queryParameters:
            target.method != HTTPMethod.get ? {} : target.parameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      var json = response.data;
      var status = json[PGSpiManager.shared.key.status];
      if (status == PGSpiManager.shared.key.success) {
        if (json[PGSpiManager.shared.key.data] == null) {
          return [];
        }
        if (designatedPath == null || designatedPath.length <= 0) {
          return json[PGSpiManager.shared.key.data];
        }
        if (json[PGSpiManager.shared.key.data][designatedPath] == null) {
          throw DioError(
            error: PGSpiError.exception(Exception.objectFailed),
          );
        }
        return json[PGSpiManager.shared.key.data][designatedPath];
      } else {
        if (status != null && status is int) {
          // 请求正常，操作失败
          throw DioError(
            error: PGSpiError.exception(
              Exception.executeFail,
              status: status,
              message: json[PGSpiManager.shared.key.msg],
            ),
          );
        }
        // 请求结果状态码不合法
        throw DioError(
          error: PGSpiError.exception(Exception.unlegal),
        );
      }
    } on DioError {
      throw DioError(
        error: PGSpiError.exception(Exception.unacceptableStatusCode),
      );
    }
  }
}
