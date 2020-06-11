enum HTTPMethod {
  get,
  post,
  put,
  patch,
  delete,
  trace,
  connect,
}

extension HTTPMethodEx on HTTPMethod {
  String get value =>
      ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'TRACE', 'CONNECT'][this.index];
}

abstract class PGSpiTarget {
  // 发出网络请求的基础地址字符串
  String get baseUrl;

  /// 网络请求的路径字符串
  String get path;

  /// 网络请求的方式，默认返回get
  HTTPMethod get method => HTTPMethod.post;

  /// 网络请求参数
  Map<String, dynamic> get parameters => null;

  /// 网络请求头
  Map<String, String> get headers => null;

  /// 日志输出
  bool get logEnable => true;
}
