import 'package:flutter/material.dart';

class Config{
  static String loginUrl;
  static String signupUrl;
  static String otpUrl;
  static String appVersion;
  static String appChannelIDorNotification;
  static String applicationName;
  static bool dummyData;
  static String isScope;

  Config(String loginurl,String signupurl,String otpurl,String appversion,String appChannelID,String appName,bool dummyValue,String isScopeValue){
    loginUrl = loginurl;
    otpUrl = otpurl;
    signupUrl = signupurl;
    appVersion = appversion;
    appChannelIDorNotification = appChannelID;
    applicationName = appName;
    dummyData = dummyValue;
    isScope = isScopeValue;
  }

}