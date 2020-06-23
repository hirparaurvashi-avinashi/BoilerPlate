library boilerplate;
import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'APICalls/ServerCommunicator.dart';
import 'CommonJsonFiles/CommonStaticJsonFiles.dart';
import 'CommonToastUI/ToastMessage.dart';
import 'Constants/Config.dart';
import 'OTPModule/OtpScreen.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class LoginPage extends StatefulWidget{
  Image appIcon;
  Function afterLoginCallback;
  LoginPage({Key key, @required this.appIcon,@required this.afterLoginCallback}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AnimationController _animationController;
  var mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  Map<String,String> selectedcountry;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  onTapButton(){
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      APIProvider().doLogin(mobileController.text)
          .then((onValue) {
        if (onValue['flag']) {
          setState(() {
            isLoading = false;
          });

          widget.afterLoginCallback(onValue["data"],mobileController.text);
        } else {
          setState(() {
            isLoading = false;
          });
          return Toast.show(onValue['message'] as String, context);
        }
      });
    }
  }


  Widget mobileNumberField(){
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16,top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Container(
              width: 70,
              margin: EdgeInsets.only(top: 31),
              child: Container(
                height: 37,
                child: CommomJson.countries.length > 1 ? DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    isDense: true,
                    isExpanded: true,
                    style: TextStyle(
                      height: 0.1,
                      fontSize: 16.0,
                      fontFamily: "SourceSansPro",
                      color: Colors.grey[700],
                    ),
                    value: selectedcountry == null ? CommomJson.countries[0]["countryCode"] : selectedcountry["countryCode"],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          CommomJson.countries.forEach((element) {
                            if(element["countryCode"] == value){
                              selectedcountry = element;
                            }
                          });
                        });
                      }
                    },
                    items: CommomJson.countries.map((country) {
                      return new DropdownMenuItem(
                        child: Text(country["countryCode"]),
                        value: country["countryCode"],
                      );
                    }).toList(),
                  ),
                ) : Text(
                      CommomJson.countries[0]["countryCode"],
                    style: Theme.of(context).textTheme.headline5,
                    ),
              ),
            ) ,
//            Text(
//              CommomJson.countries[0]["countryCode"]
//            ),
//            SizedBox(width: CommomJson.countries.length > 1 ? 10 : 0,),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: mobileController,
                decoration: InputDecoration(
                    prefixIcon:Icon(Icons.stay_current_portrait, size: 18,color: DesignCourseAppTheme.appThemeColor,),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(color: DesignCourseAppTheme.appThemeColor, width: 2.0),
                    ),
                    labelText: "Enter mobile number",
                    labelStyle: DesignCourseAppTheme.styleWithTextTheme,
                    focusColor: DesignCourseAppTheme.appThemeColor
                ),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Mobile number can't be blank";
                  } else {
                    if (value.length < 10) {
                      return "Please enter valid mobile number";
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        )
    );
  }

  Widget loginButtonUI(){
    return Container(
      height: 60,
        margin: EdgeInsets.only(left: 16, right: 16, top: 30),
        child: Container(
          child: Material(
            borderRadius: BorderRadius.circular(5),
            color: DesignCourseAppTheme.appThemeColor,
            child: InkWell(
              // When the user taps the button, show a snackbar.
              onTap: () {
                if(Config.dummyData){
                  widget.afterLoginCallback("",mobileController.text);
                }else{
                  onTapButton();
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child:
                isLoading
                    ? SpinKitThreeBounce(
                  color: DesignCourseAppTheme.white,
                  size: 30.0,
                )
                    :
                Text("Login",
                  style: DesignCourseAppTheme.tansprentFontColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F3F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              child: ResponsiveGridRow(children: [
                ResponsiveGridCol(
                    xs: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 50),
                          child: widget.appIcon
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("Login",style: Theme.of(context).textTheme.headline5,),
                        ),

                        mobileNumberField(),
                        loginButtonUI()
                      ],
                    ))
              ]),
            ),
          ),

        ),
      ),
    );

  }

}