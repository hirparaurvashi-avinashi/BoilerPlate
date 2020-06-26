import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LogManagement {
  static Future<bool> askPhonePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage].isGranted) {
      return true;
    } else  if (statuses[Permission.storage].isDenied){
      return false;
    }
  }

  static initializeLogger(String url) async {
    if (await askPhonePermission()) {
      var documentDirectory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      var configHandler = {
        'appenders': [
          {
            'type': 'FILE',
            'format': '%d %t %l %m',
            'level': 'INFO',
            'filePattern': 'unittest',
            'fileExtension': 'txt',
            'path': '${documentDirectory.path}',
            'rotationCycle': 'DAY'
          },
          {
            'type': 'HTTP',
            'dateFormat': 'yyyy-MM-dd HH:mm:ss',
            'level': 'INFO',
            'url': '$url',
            'headers': ['Content-Type:application/json']
          }
        ],
      };

      Logger().registerAllAppender([FileAppender(), HttpAppender()]);

      var yesterDay = DateTime.now().subtract(Duration(days: 1));

      await Logger().init(configHandler, date: yesterDay);
    } else {
      initializeLogger(url);
    }
  }

  static addInfoLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.INFO;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.INFO;

      Logger().info(tag, message);
    }
  }

  static addDebugLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.DEBUG;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.DEBUG;

      Logger().debug(tag, message);
    }
  }

  static addWarningLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.WARNING;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.WARNING;

      Logger().info(tag, message);
    }
  }

  static addErrorLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.ERROR;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.ERROR;

      Logger().info(tag, message);
    }
  }

  static addFatalLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.FATAL;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.FATAL;

      Logger().info(tag, message);
    }
  }

  static addAllLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.ALL;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.ALL;

      Logger().info(tag, message);
    }
  }

  static addTraceLog({@required String tag, @required String message}) {
    if (Logger().appenders.length > 0) {
      var file = Logger().appenders.elementAt(0) as FileAppender;
      file.level = Level.TRACE;

      var http = Logger().appenders.elementAt(1) as HttpAppender;
      http.level = Level.TRACE;

      Logger().info(tag, message);
    }
  }
}

var config = {
  'appenders': [
    {
      'type': 'CONSOLE',
      'dateFormat': 'yyyy-MM-dd HH:mm:ss',
      'format': '%d %i %t %l %m',
      'level': 'INFO'
    },
    {
      'type': 'FILE',
      'dateFormat': 'yyyy-MM-dd HH:mm:ss',
      'format': '%d %i %t %l %m',
      'level': 'INFO',
      'filePattern': 'log4dart2_log',
      'fileExtension': 'txt',
      'path': '/path/to/',
      'rotationCycle': 'MONTH'
    },
    {
      'type': 'EMAIL',
      'dateFormat': 'yyyy-MM-dd HH:mm:ss',
      'level': 'INFO',
      'host': 'smtp.test.de',
      'user': 'test@test.de',
      'password': 'test',
      'port': 1,
      'fromMail': 'test@test.de',
      'fromName': 'Jon Doe',
      'to': ['test1@example.com', 'test2@example.com'],
      'toCC': ['test1@example.com', 'test2@example.com'],
      'toBCC': ['test1@example.com', 'test2@example.com'],
      'ssl': true,
      'templateFile': '/path/to/template.txt',
      'html': false
    },
    {
      'type': 'HTTP',
      'dateFormat': 'yyyy-MM-dd HH:mm:ss',
      'level': 'INFO',
      'url': 'api.example.com',
      'headers': ['Content-Type:application/json']
    },
    {
      'type': 'MYSQL',
      'level': 'INFO',
      'host': 'database.example.com',
      'user': 'root',
      'password': 'test',
      'port': 1,
      'database': 'mydatabase',
      'table': 'log_entries'
    }
  ]
};
