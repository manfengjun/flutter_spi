enum Exception {
  // 网络异常
  networkException,
  // invalidURL
  invalidURL,
  // 服务器异常 500
  serverException,
  // 方法不存在 404
  notFound,
  // ContentType 不被接受
  unacceptableContentType,
  // 响应状态异常
  unacceptableStatusCode,
  // data缺失
  dataNotFound,
  // JSON序列化异常
  jsonSerializationFailed,
  // 对象转换失败
  objectFailed,
  // 执行结果状态吗不合理
  unlegal,
  // 执行结果异常，操作失败
  executeFail,
}

extension ExceptionEx on Exception {
  int get value => index + 10000;
}

class PGSpiError extends Error {
  Exception exception;
  int status;
  String message = '请求失败';

  PGSpiError._init(this.status, {this.message});
  factory PGSpiError.exception(Exception exception,
      {int status, String message}) {
    int code = status != null ? status : exception.value;
    String msg = message != null ? message : spiCode[exception.value].msg;
    return PGSpiError._init(code, message: msg);
  }
}

Map<int, Tuple> spiCode = {
  10000: Tuple(10000, '网络异常，请稍后重试！'),
  10001: Tuple(10001, '请求地址异常'),
  10002: Tuple(10002, '服务器异常，请稍后重试！'),
  10003: Tuple(10003, '接口未找到'),
  10004: Tuple(10004, 'Content-Type异常'),
  10005: Tuple(10005, '响应状态异常'),
  10006: Tuple(10006, '没有数据节点'),
  10007: Tuple(10007, 'JSON序列化异常'),
  10008: Tuple(10008, '对象序列化异常'),
  10009: Tuple(10009, '缺省状态节点'),
};

class Tuple<T> {
  final int status;
  final T msg;

  Tuple(this.status, this.msg);
}
