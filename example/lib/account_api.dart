
import 'package:flutter_spi/flutter_spi.dart';

import 'constant.dart';

enum Account { login }

extension AccountAPI on Account {
  static login(Map<String, dynamic> params) =>
      AccountTarget(Account.login, params: params);
}

class AccountTarget with PGSpiTarget {
  final Account type;
  Map<String, dynamic> params = {};
  @override
  String get baseUrl => Constant.baseUrl;

  @override
  String get path {
    switch (type) {
      case Account.login:
        return Constant.api + '/toutiao/index';
        break;
      default:
        return '';
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case Account.login:
        return HTTPMethod.get;
        break;
      default:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, dynamic> get parameters => params;

  @override
  Map<String, String> get headers => {"version": "1.0"};

  AccountTarget(this.type, {this.params});
}
