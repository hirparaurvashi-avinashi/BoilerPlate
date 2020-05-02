library boilerplate;

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
            backgroundColor: Color.fromARGB(
                255, 64, 196, 175),
            title: new Text("App update available",
              style: TextStyle(color: Colors.white,),),
            content: Text(appVersionMessage,
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Update",
                  style: TextStyle(fontWeight: FontWeight.bold),),
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
    return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            backgroundColor: Color.fromARGB(
                255, 64, 196, 175),
            title: new Text("App update available",
              style: TextStyle(color: Colors.white),),
            content: Text(appVersionMessage,
                style: TextStyle(color: Colors.white)),
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
                  style: TextStyle(fontWeight: FontWeight.bold),),
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