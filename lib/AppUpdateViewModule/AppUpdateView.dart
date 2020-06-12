library boilerplate;

import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class CustomComplusaryAppUpdateAlertBox{
  static Future showCustomAlertBox({
    @required BuildContext context,
    @required String appVersionMessage,
    @required String androidAppId,
    @required String iosAppId
}){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            backgroundColor: DesignCourseAppTheme.appThemeColor,
            title: new Text("App update available",
              style: TextStyle(color: DesignCourseAppTheme.darkText,),),
            content: Text(appVersionMessage,
                style: TextStyle(color: DesignCourseAppTheme.darkText)),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Update",
                  style: DesignCourseAppTheme.body1,),
                onPressed: () async {
                  StoreRedirect.redirect(androidAppId: androidAppId,
                      iOSAppId: iosAppId);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomRecommandedAppUpdateAlertBox{
  static Future showCustomAlertBox({
    @required BuildContext context,
    @required String appVersionMessage,
    @required String androidAppId,
    @required String iosAppId,
    @required Function tapOnLaterUpdate
  }){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            backgroundColor: DesignCourseAppTheme.appThemeColor,
            title: new Text("App update available",
              style: TextStyle(color: DesignCourseAppTheme.darkText),),
            content: Text(appVersionMessage,
                style: TextStyle(color: DesignCourseAppTheme.darkText)),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Later"),
                onPressed: () async {
                  tapOnLaterUpdate();
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Update",
                  style: DesignCourseAppTheme.body1,),
                onPressed: () async {
                  StoreRedirect.redirect(androidAppId: androidAppId,
                      iOSAppId: iosAppId);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}