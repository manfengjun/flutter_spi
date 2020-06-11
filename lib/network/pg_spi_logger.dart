import 'package:dio/dio.dart';
import 'dart:convert';

import 'pg_spi_error.dart';

// 拦截器
class LogsInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("✅ " + '${options.path}');
    print('✅ METHOD:${options.method}');
    if (options.method == 'GET') {
      print('✅ Body:${options.queryParameters}');
    } else {
      print('✅ Body:${options.data}');
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (response != null) {
      var json = jsonDecode(response.data);
      if (json != null) {
        print('🇨🇳 Return Data:');
        print('🇨🇳 $json');
      } else {
        print('🇨🇳 JSON 解析异常');
      }
    } else {
      print('🇨🇳 response 不存在');
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError e) {
    if (e.error is PGSpiError) {
      print('❌ ${e.error.status} ---- ${e.error.message}');
    } else {
      print('❌ ${e.toString() ?? "无错误描述"})');
    }
    return super.onError(e);
  }
}
