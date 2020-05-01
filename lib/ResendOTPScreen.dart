import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendTimerScreen extends StatefulWidget {
  bool isButtonDisable;
  Function callback;
  ResendTimerScreen({
    Key key,
    @required this.isButtonDisable,
    @required this.callback,
  }) : super(key: key);

  @override
  ResendTimerScreenState createState() {
    return new ResendTimerScreenState();
  }
}

class ResendTimerScreenState extends State<ResendTimerScreen> {
  Timer _timer;
//  Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    widget.isButtonDisable = true;
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.only(left: 25, right: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: StatefulBuilder(
              builder: (context,setState){
                return Text.rich(
                  TextSpan(
                    text: "If you don't receive a code!",
                    style: TextStyle(
                      height: 1.0,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SourceSansPro",
                      color: Colors.grey[700],
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: _start == 0
                            ? ' Resend'
                            : _start >= 10
                            ? ' 00:' + _start.toString()
                            : ' 00:0' + _start.toString(),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = widget.isButtonDisable
                              ? null
                              : () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _start = 30;
                            startTimer();
                            widget.callback();
                          },
                        style: TextStyle(
                          height: 1.0,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SourceSansPro",
                          color: widget.isButtonDisable
                              ? Colors.grey[700]
                              : Color.fromRGBO(72, 131, 155, 1.0),
                        ),
                      ),
                    ],
                  ),
                  textAlign:TextAlign.center,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}