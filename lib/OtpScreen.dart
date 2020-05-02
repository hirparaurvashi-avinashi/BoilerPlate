library boilerplate;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'APICalls/ServerCommunicator.dart';
import 'CommonToastUI/ToastMessage.dart';
import 'ResendOTPScreen.dart';

class OTPScreenPage extends StatefulWidget {
  String mobileToken;
  String mobileNumber;
  String loginurl;
  String otpUrl;
  Image applogo;
  Function verifyAndResendOtpCallback;

  @override
  _OTPScreenState createState() => _OTPScreenState();

  OTPScreenPage({
    Key key,
    @required this.mobileToken,
    @required this.mobileNumber,
    @required this.applogo,
    @required this.loginurl,
    @required this.otpUrl,
    @required this.verifyAndResendOtpCallback,
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
//    setState(() {
//      isLoading = true;
//    });
//
//    if (otpCode != null) {
//      code = otpCode;
//    }
//
//    if (code.isEmpty && code.length != 4) {
//      setState(() {
//        isLoading = false;
//      });
//      return Toast.show('Please enter otp', context);
//    }
//
//    setState(() {
//      isLoading = true;
//    });

    if (widget.mobileToken == "") {
      setState(() {
        isLoading = true;
      });
      APIProvider().doLogin(widget.mobileNumber,widget.loginurl).then((
          onValue) {
        if (onValue['flag']) {
          setState(() {
            isLoading = false;
          });
          setState(() {
            otpToken = onValue['data'] as String;
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
        APIProvider().verifyOTP(otpToken as String,int.parse(otpCode),widget.otpUrl)
            .then((onValue) {
          if (onValue['flag']) {
              isLoading = false;
              widget.verifyAndResendOtpCallback(otpToken,onValue);
          } else {
            otpCode = "";
              isLoading = false;
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
    APIProvider().doLogin(widget.mobileNumber,widget.loginurl)
        .then((onValue) {
      if (onValue['flag']) {
        setState(() {
          isResend = false;
          otpToken = onValue['data'] as String;
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
                SizedBox(
                  height: 120.0,
                  child: widget.applogo,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5, left: 0, right: 0),
                  child: Text.rich(
                    TextSpan(
                      text: 'OTP has been sent to Mobile No. ',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "SourceSansPro",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.mobileNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(72, 131, 155, 1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child:
                  PinFieldAutoFill(
                    codeLength: 4,
                    decoration: UnderlineDecoration(
                        textStyle: TextStyle(
                            color: Color(0xFF1976d2),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        color: Color(0xFF1976d2)),
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
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                    child: InkWell(
                      // When the user taps the button, show a snackbar.
                      onTap: () {
                        if(!isLoading){
//                          tapOnButton();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: isLoading
                            ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30.0,
                        )
                            : Text("VerifyOTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
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