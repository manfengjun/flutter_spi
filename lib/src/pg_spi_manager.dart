class PGSpiManager {
  PGSpiConfig config = PGSpiConfig();
  ResponseKey key = ResponseKey();

  // 工厂模式
  factory PGSpiManager() => _getInstance();
  static PGSpiManager get shared => _getInstance();
  static PGSpiManager _instance;
  PGSpiManager._internal();
  static PGSpiManager _getInstance() {
    if (_instance == null) {
      _instance = new PGSpiManager._internal();
    }
    return _instance;
  }
}

class PGSpiConfig {
  int connectTimeout;
  int receiveTimeout;
  bool logEnable;
  PGSpiConfig({
    this.connectTimeout = 5000,
    this.receiveTimeout = 100000,
    this.logEnable = true,
  });
}

class ResponseKey {
  String data;
  String msg;
  String status;
  int success;
  ResponseKey({
    this.data = 'data',
    this.msg = 'msg',
    this.status = 'status',
    this.success = 1,
  });
}
