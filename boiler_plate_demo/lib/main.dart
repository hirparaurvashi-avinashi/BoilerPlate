import 'package:flutter/material.dart';
import 'DashboardScreen.dart';
import 'package:boilerplate/boilerplate.dart';
import 'package:boilerplate/APICalls/ServerCommunicator.dart';
import 'package:boilerplate/OTPModule/OtpScreen.dart';
import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:boilerplate/Constants/Config.dart';
import 'package:boilerplate/Notification/FireBaseNotifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogin = false;
  bool isOtpSend = false;
  int appVersionStatus = 1;
  String versionMessage = "";

  String otpToken = "";
  String mobilenumber = "";

  @override
  void initState() {
    super.initState();
    configFileSet();
    checkAppVersion();
    isLogin = false;
    isOtpSend = false;
  }

  configFileSet(){
    DesignCourseAppTheme(Colors.blueGrey);
    Config("http://api.bmf.avinashi.com/api/v1/directLogin/sendOtp",
        "http://api.bmf.avinashi.com//api/v1/login",
        "http://api.bmf.avinashi.com/api/v1/verify/otp",
        "http://api.bmf.avinashi.com/api/v1/checkAppVersion",
      "bookmyfarm_app_channel_id",
      "BookMyFarm App"
    );
    FireBaseNotificationEvents(tapOnNotification,onSelectLocalNotification,getTokenEvent,getOnMessageEvent,getOnResumeMessageEvent,getOnLaunchMessageEvent);
    FireBaseNotificationEvents.intializeLocalNotification();
    FireBaseNotificationEvents.fireBaseCloudMessagingListeners();
  }

  tapOnNotification(Map<String, dynamic> payload){
    print(payload);
  }

  onSelectLocalNotification(Map<String, dynamic> payload){
    print(payload);
  }

  getTokenEvent(String token){
    print(token);
  }

  getOnMessageEvent(Map<String, dynamic> payload){
    print(payload);
    //Database handling
    FireBaseNotificationEvents.showNotification(payload, "");
  }

  getOnResumeMessageEvent(Map<String, dynamic> payload){
    print(payload);
    FireBaseNotificationEvents.onTapNotification(payload);
  }

  getOnLaunchMessageEvent(Map<String, dynamic> payload){
    print(payload);
    FireBaseNotificationEvents.onTapNotification(payload);
  }

  checkAppVersion()async {
   await APIProvider().checkAppVersions().then((onValue){
     if (onValue["flag"] == true) {} else {
       if (onValue["code"] == 104) {
         //recomamded
         versionMessage = onValue["message"] as String;
         appVersionStatus = 104;
       } else if (onValue["code"] == 103) {
         versionMessage = onValue["message"] as String;
         appVersionStatus = 103;
       }
     }
   });
  }

  afterLoginWithOTPCompleteCallback(String token,dynamic message){
    print(token);
    print(message);
      setState(() {
        isLogin = true;
      });

  }

  setValuesinPrefrences(){

  }

  loginResponse(String token,String mobileNumberValue){
    mobilenumber = mobileNumberValue;
    otpToken = token;
    setState(() {
      isOtpSend = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
//        isLogin ?
        DAshboardScreen(appVersionMessage: versionMessage,appVersionStatus: appVersionStatus,)
//            : isOtpSend ? OTPScreenPage(
//          verifyOtpCallback: afterLoginWithOTPCompleteCallback,
//          appIcon: Image(image: AssetImage('assets/logo.png'),height: 150.0),
//          mobileNumber: mobilenumber,
//          mobileToken: otpToken,
//        )
//            : LoginPage(appIcon: Image(image: AssetImage('assets/logo.png'),height: 150.0),
//          afterLoginCallback: loginResponse,
//        )
    );
  }
}
