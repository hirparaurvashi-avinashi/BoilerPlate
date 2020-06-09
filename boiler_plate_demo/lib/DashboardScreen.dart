import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/AppUpdateViewModule/AppUpdateView.dart';

import 'package:boilerplate/CommonToastUI/ToastMessage.dart';


class DAshboardScreen extends StatefulWidget{
  int appVersionStatus;
  String appVersionMessage;

  DAshboardScreen({Key key,
    @required this.appVersionStatus,
    @required this.appVersionMessage
  }) : super(key: key);


  @override
  DAshboardScreenState createState() => DAshboardScreenState();
}

class DAshboardScreenState extends State<DAshboardScreen> {

  @override
  void initState() {
    super.initState();

//    Future.delayed(const Duration(milliseconds: 500), () async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      final lastAskedUpdate = prefs.getInt('last_asked_for_recomanded_update');
//
//      if (widget.appVersionStatus == 103) {
//        await CustomComplusaryAppUpdateAlertBox.showCustomAlertBox(
//            context: context,
//            appVersionMessage: widget.appVersionMessage,
//            androidAppId: "",
//            iosAppId: "",
//
//        );
//      } else if (widget.appVersionStatus == 104 &&
//          ((lastAskedUpdate ?? 0) + 86400000000) < DateTime
//              .now()
//              .microsecondsSinceEpoch) {
//        await CustomRecommandedAppUpdateAlertBox.showCustomAlertBox(
//            context: context,
//            appVersionMessage: widget.appVersionMessage,
//            androidAppId: "",
//            iosAppId: "",
//            tapOnLaterUpdate: tapOnLaterUpdate
//
//        );
//      }
//    });
  }

//  tapOnLaterUpdate() async{
//    SharedPreferences prefs = await SharedPreferences
//        .getInstance();
//    prefs.setInt('last_asked_for_recomanded_update', DateTime
//        .now()
//        .microsecondsSinceEpoch);
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Screen"),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Toast.show("Error Getting", context);
              },
              child: Center(
                child: Text("Show Error Toast"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
