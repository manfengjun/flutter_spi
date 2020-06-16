// RxDart
import 'package:flutter_spi/flutter_spi.dart';

import '../bean/base_bean.dart';

extension PGSpiRx on PGSpi {
  // object stream
  Stream<T> mapSpiObject<T>({String path}) => this
      .responseSpiJson(path: path)
      .asStream()
      .map((value) => BaseBeanEntity.fromJson(value).object<T>());
  // objects stream
  Stream<List<T>> mapSpiObjects<T>({String path}) => this
      .responseSpiJsons(path: path)
      .asStream()
      .map((value) => BaseBeanEntity.fromJsonList(value).objects<T>());
}
