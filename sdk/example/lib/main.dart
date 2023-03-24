import 'package:flutter/material.dart';
import 'package:fair_pushy/fair_pushy.dart';
import 'package:fair/fair.dart';
import 'car_module/car_detail_delegate.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FairPushy.init(
      appID: '28',
      updateUrl: "http://192.168.0.106:8080/app/patch",
      debug: false);
  // FairPushy.setProxy('PROXY 10.252.206.119:8888');

  FairDevTools.config = FairDevConfig()
    ..addEnv(OnlineEnvInfo(
        envName: '环境1',
        updateUrl: 'http://192.168.0.106:8080/app/patch',
        readOnly: true))
    ..addEnv(OnlineEnvInfo(envName: '环境2', updateUrl: '', readOnly: false));

  /// 如果使用了中间件，且中间件中目标页的传入方式是通过pageName的方式，则需要把目标页注册到FairPushy中，
  /// {pagename : (context, params) => Widget()}的方式
  FairPushy.registerPageBuilders(
      {"dynamic_page": (context, params) => FairWidget(path: params?['path'])});

  runApplication();
}

void runApplication() {
  FairApp.runApplication(
    FairApp(
        child: MyApp(),
        delegate: {"car_detail": (_, data) => CarDetailDelegate()}),
    plugins: {},
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}
