import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DAshboardScreen extends StatefulWidget{

  DAshboardScreen({Key key}) : super(key: key);

  @override
  DAshboardScreenState createState() => DAshboardScreenState();
}

class DAshboardScreenState extends State<DAshboardScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Screen"),
      ),
      body: Center(
        child: Text("Hello Dashboard"),
      ),
    );
  }

}
