import 'dart:async';

import 'package:HotUpdateService/pages/project/data/data_dao/project_model_dao.dart';
import 'package:HotUpdateService/server/fair_server_pages.dart';
import 'package:HotUpdateService/server/src/get_server.dart';
import 'package:HotUpdateService/utils/fair_logger.dart';
import 'package:settings_yaml/settings_yaml.dart';
import 'package:simple_mysql_orm/simple_mysql_orm.dart';
import 'config.dart';

void main() async {
  LoggerInit();

  // Create  settings file.
  // SettingsYaml.fromString(content: settingsYaml, filePath: 'settings.yaml')
  //     .save();

  /// Initialise the db pool
  // DbPool.fromSettings(pathToSettings: 'settings.yaml');
  DbPool.fromArgs(host: "localhost",user: "root",password: "zz3910629", database: 'fair',);


  var appList = [];

  await withTransaction<void>(action: () async {
    final dao = ProjectDao();
    final projectList = await dao.getAll();
    for (var project in projectList) {
      appList.add(project.toJson());
    }
  }).catchError(((error, stack) {
    print("ProjectListPage" + error.toString());
  }));

  print(appList);
  runApp(
    GetServer(
      host: '0.0.0.0',
      getPages: AppPages.routes,
      port: 8080,
    ),
  );
  print("FairServer ready...");
}
