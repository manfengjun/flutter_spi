import 'dart:convert';

import 'package:dio/dio.dart';

import 'pg_spi_error.dart';

// 拦截器
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    if (response.statusCode != 200) {
      // 非200
      throw DioError(
        error: PGSpiError.exception(Exception.unacceptableStatusCode),
      );
    }
    if (response.data == null) {
      // data 为空
      throw DioError(
        error: PGSpiError.exception(Exception.dataNotFound),
      );
    }
    var json = jsonDecode(response.data);
    if (json == null) {
      // data 不是json对象
      throw DioError(
        error: PGSpiError.exception(Exception.jsonSerializationFailed),
      );
    }
    response.data = json;
    return super.onResponse(response);
  }
}
