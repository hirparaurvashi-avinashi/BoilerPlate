import 'package:flutter/material.dart';

class Config{
  static String loginUrl;
  static String otpUrl;
  static String appVersion;

  Config(String loginurl,String otpurl,String appversion){
    loginUrl = loginurl;
    otpUrl = otpurl;
    appVersion = appversion;
  }

}