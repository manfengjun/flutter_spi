import 'package:flutter/material.dart';
import 'package:flutter_spi/flutter_spi.dart';

import 'account_api.dart';
import 'news.dart';
import 'network/rx/rx_extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 设置解析Key和成功状态
    PGSpiManager.shared.key = ResponseKey(
      data: 'result',
      status: 'error_code',
      msg: 'reason',
      success: 0,
    );
    // 请求示例
    PGSpi(AccountAPI.login(
            {"type": "top", "key": "8093f06289133b469be6ff7ab6af1aa9"}))
        .mapSpiObjects<News>(path: "data")
        .listen(
      (value) => print(value[0].authorName),
      onError: (e) {
        //获取失败
        print((e.error as PGSpiError).message);
      },
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text('Dio Extension')),
    );
  }
}
