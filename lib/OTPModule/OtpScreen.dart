import 'package:boilerplate/Constants/Config.dart';
import 'package:boilerplate/ResendOTPModule/ResendOTPScreen.dart';
import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../APICalls/ServerCommunicator.dart';
import '../CommonToastUI/ToastMessage.dart';

class OTPScreenPage extends StatefulWidget {
  String mobileToken;
  String mobileNumber;
  Image appIcon;
  Function verifyOtpCallback;

  @override
  _OTPScreenState createState() => _OTPScreenState();

  OTPScreenPage({
    Key key,
    @required this.mobileToken,
    @required this.mobileNumber,
    @required this.appIcon,
    @required this.verifyOtpCallback,
  }) : super(key: key);
}

class _OTPScreenState extends State<OTPScreenPage> {
  TextEditingController otpController = TextEditingController();

  var focusNodeForOTP = new FocusNode();

  bool isLoading = false;
  var otpToken;
  var isResend = false;

  int _start = 30;

  bool _isButtonDisabled;

  String otpCode;

  @override
  void initState() {
    super.initState();
    otpToken = widget.mobileToken;
    _isButtonDisabled = true;
    setResendAfterTime();
    autoDetectOTP();
    _start = 0;
  }

  @override
  void dispose() {
    focusNodeForOTP.dispose();
    super.dispose();
  }

  void autoDetectOTP() async {
    await SmsAutoFill().listenForCode;
    var signature = await SmsAutoFill().getAppSignature;
    print(signature);
    setState(() {
    });
  }

  void setResendAfterTime() {
    Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  void verifyOtp() async {
    focusNodeForOTP.unfocus();
    _isButtonDisabled = true;
    if (widget.mobileToken == "") {
      setState(() {
        isLoading = true;
      });
      APIProvider().doLogin(widget.mobileNumber).then((
          onValue) {
        if (onValue['flag']) {
          setState(() {
            isLoading = false;
          });
          setState(() {
            otpToken = onValue['data']["id"];
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Toast.show(onValue['message'] as String, context);
        }
      });
    } else {
      if (otpCode.length == 4) {
        setState(() {
          isLoading = true;
        });
        APIProvider().verifyOTP(otpToken as String,int.parse(otpCode))
            .then((onValue) {
          if (onValue['flag']) {
              isLoading = false;
              widget.verifyOtpCallback(otpToken,onValue);
          } else {
            setState(() {
              isLoading = false;
              otpCode = "";
            });
            Toast.show(onValue['message'], context);
          }
        });
      } else {
        Toast.show("Please enter valid OTP", context);
      }
    }
  }

  void tapOnReSendOtp() async {
    setState(() {
      isResend = true;
      _isButtonDisabled = true;
      otpCode = "";
      setResendAfterTime();
    });
    APIProvider().doLogin(widget.mobileNumber)
        .then((onValue) {
      if (onValue['flag']) {
        setState(() {
          isResend = false;
          otpToken = onValue['data']["id"];
        });
      } else {
        setState(() {
          isResend = false;
        });
        return Toast.show(onValue['message'] as String, context);
      }
    });
  }

  removefocusfield(){
    FocusScope.of(context).unfocus();
  }

  Widget otpField(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child:
      PinFieldAutoFill(
        codeLength: 4,
        decoration: UnderlineDecoration(
            textStyle: DesignCourseAppTheme.headline,
            color: DesignCourseAppTheme.appThemeColor),
        autofocus: false,
        focusNode: isLoading || isResend ? removefocusfield() : focusNodeForOTP ,
        currentCode: otpCode,
        onCodeChanged: (code) {
          print('OTP:-' + code);
          if (code.length == 4) {
            removefocusfield();
            otpCode = code;
            verifyOtp();
          }
        },
      ),
    );
  }

  Widget verifiOTPButton(){
    return Container(
      height: 60,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: DesignCourseAppTheme.appThemeColor,
        child: InkWell(
          // When the user taps the button, show a snackbar.
          onTap: () {
            if(Config.dummyData){
              widget.verifyOtpCallback(otpToken,"");
            }else{
              if(!isLoading){
//                          tapOnButton();
              }
            }

          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: isLoading
                ? SpinKitThreeBounce(
              color: DesignCourseAppTheme.white,
              size: 24.0,
            )
                : Text("VerifyOTP",
              style: DesignCourseAppTheme.tansprentFontColor,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.appIcon,
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5, left: 0, right: 0),
                  child: Text.rich(
                    TextSpan(
                      text: 'OTP has been sent to Mobile No. ',
                      style: DesignCourseAppTheme.body1,
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.mobileNumber ?? "",
                          style: DesignCourseAppTheme.styleWithTextTheme,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                otpField(),
                SizedBox(
                  height: 30,
                ),
                verifiOTPButton(),
                SizedBox(
                  height: 20,
                ),
                ResendTimerScreen(callback: tapOnReSendOtp,isButtonDisable: _isButtonDisabled)
              ],
            ),
          ),
        ),
      )
    );
  }
}