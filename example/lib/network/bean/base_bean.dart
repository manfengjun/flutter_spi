import 'package:example/news.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "News") {
      return News.fromJson(json) as T;
    } else {
      return null;
    }
  }
}

/// 解析基类
class BaseBeanEntity<T> {
  Map<String, dynamic> results;
  List<dynamic> resultsList = [];

  BaseBeanEntity({this.results, this.resultsList});

  /// 处理results为对象的情况
  BaseBeanEntity.fromJson(Map<String, dynamic> json) {
    results = json;
  }

  /// 处理results为数组的情况
  BaseBeanEntity.fromJsonList(List<Map<String, dynamic>> json) {
    resultsList = json;
  }

  /// 获取results对象
  T object<T>() {
    return EntityFactory.generateOBJ<T>(results); //使用EntityFactory解析对象
  }

  /// 获取results数组
  List<T> objects<T>() {
    var list = new List<T>();
    if (resultsList != null) {
      resultsList.forEach((v) {
        //拼装List
        list.add(EntityFactory.generateOBJ<T>(v)); //使用EntityFactory解析对象
      });
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data = this.results;
    }
    return data;
  }
}
