import 'package:flutter/material.dart';

class Config{
  static String loginUrl;
  static String otpUrl;
  static String appVersion;
  static String appChannelIDorNotification;
  static String applicationName;


  Config(String loginurl,String otpurl,String appversion,String appChannelID,String appName){
    loginUrl = loginurl;
    otpUrl = otpurl;
    appVersion = appversion;
    appChannelIDorNotification = appChannelID;
    applicationName = appName;
  }

}