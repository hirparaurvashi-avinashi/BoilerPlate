
import 'package:boilerplate/APICalls/ServerCommunicator.dart';
import 'package:boilerplate/CommonToastUI/ToastMessage.dart';
import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  Image appIcon;
  Function afterSignUpCallback;
  SignUpWithEmailScreen(
      {Key key,
        @required this.appIcon,@required this.afterSignUpCallback
      })
      : super(key: key);

  @override
  SignUpWithEmailState createState() {
    return new SignUpWithEmailState();
  }
}

class SignUpWithEmailState extends State<SignUpWithEmailScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  var passwordVisible = true;
  var isLoading = false;

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool checkValidation() {
    FocusScope.of(context).requestFocus(new FocusNode());
//    _emailFocus.unfocus();
//    _passwordFocus.unfocus();

    if ((EmailValidator.validate(emailController.text) == true)) {
      if (passwordController.text.isNotEmpty) {
        // make api call
        buttonHandlerOnLogin();
        return true;
      } else {
        // password is blank
        Toast.show("Password can not be blank", context);
        return false;
      }
    } else {
      // email validation failed
      Toast.show("Please enter valid email", context);
      return false;
    }
  }

  void buttonHandlerOnLogin() async {
    setState(() {
      isLoading = true;
    });
    APIProvider().doLoginWithEmail(emailController.text, passwordController.text)
        .then((onValue) {
      if (onValue['flag']) {
        setState(() {
          isLoading = false;
        });
        widget.afterSignUpCallback(onValue["data"].toString());
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                  title: Text("Alert!"),
                  content: Text(onValue["message"]),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GestureDetector(
        child: Container(
          child: Stack(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      widget.appIcon,
                      SizedBox(height: 10,),
                      new Container(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: new Text(
                                'SIGN IN',
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          enabled: isLoading ? false : true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                          ),
                          focusNode: _emailFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(
                                context, _emailFocus, _passwordFocus);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
//          width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: passwordVisible,
                          enabled: isLoading ? false : true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: DesignCourseAppTheme.appThemeColor,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  passwordVisible
                                      ? passwordVisible = false
                                      : passwordVisible = true;
                                });
                              },
                            ),
                          ),
                          focusNode: _passwordFocus,
                          onFieldSubmitted: (term) {
                            _passwordFocus.unfocus();
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new SizedBox(
                            height: 50.0,
                            child: new RaisedButton(
                                elevation: 0.0,
                                child: isLoading ? SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 30.0,
                                ) : new Text('LOGIN',
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    )),
                                textColor: Colors.white,
                                color: DesignCourseAppTheme.appThemeColor,
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(5.0),
                                ),
                                onPressed: () {
                                  if (!isLoading) {
                                    checkValidation();
                                  }
                                }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
    );
  }
}
