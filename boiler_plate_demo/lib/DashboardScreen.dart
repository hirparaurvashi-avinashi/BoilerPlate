import 'package:boilerplatedemo/UUIDGEnerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/GPS/GPSReading.dart';
import 'package:boilerplate/CommonToastUI/ToastMessage.dart';
import 'package:boilerplate/CalenderProvider/CalenderRepsonseEvents.dart';
import 'package:boilerplate/ImageProviders/ImageAllEvents.dart';
import 'package:boilerplate/ImagePreview/ImagePreviewScreen.dart';
import 'package:boilerplate/SignInWithEmail/SignInWithEmailScreen.dart';
import 'package:boilerplate/CommomWidgets/CommonWidgets.dart';

class DAshboardScreen extends StatefulWidget{
  int appVersionStatus;
  String appVersionMessage;

  DAshboardScreen({Key key,
    @required this.appVersionStatus,
    @required this.appVersionMessage
  }) : super(key: key);


  @override
  DAshboardScreenState createState() => DAshboardScreenState();
}

class DAshboardScreenState extends State<DAshboardScreen> {

 static List<String> address = [];

  @override
  void initState() {
    super.initState();

//    Future.delayed(const Duration(milliseconds: 500), () async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      final lastAskedUpdate = prefs.getInt('last_asked_for_recomanded_update');
//
//      if (widget.appVersionStatus == 103) {
//        await CustomComplusaryAppUpdateAlertBox.showCustomAlertBox(
//            context: context,
//            appVersionMessage: widget.appVersionMessage,
//            androidAppId: "",
//            iosAppId: "",
//
//        );
//      } else if (widget.appVersionStatus == 104 &&
//          ((lastAskedUpdate ?? 0) + 86400000000) < DateTime
//              .now()
//              .microsecondsSinceEpoch) {
//        await CustomRecommandedAppUpdateAlertBox.showCustomAlertBox(
//            context: context,
//            appVersionMessage: widget.appVersionMessage,
//            androidAppId: "",
//            iosAppId: "",
//            tapOnLaterUpdate: tapOnLaterUpdate
//
//        );
//      }
//    });
  }

//  tapOnLaterUpdate() async{
//    SharedPreferences prefs = await SharedPreferences
//        .getInstance();
//    prefs.setInt('last_asked_for_recomanded_update', DateTime
//        .now()
//        .microsecondsSinceEpoch);
//  }

  signupResponse(String data,String mobileNumberValue){
    print(data);
  }

  String addGPSData() {
    var str = (""" 
     mutation MyMutation {
        insert_GPSTracking(objects: {address: "${address[0]}", 
        id: "${UUID().generateV4()}", 
        lat: "${address[0]}", 
        long: "${address[1]}", 
        userId:"${UUID().generateV4()}"}) {
          returning {
            id
          }
        }
      }
  """);
    return str;
  }

    @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard Screen"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Toast.show("Error Getting", context);
                },
                child: Center(
                  child: Text("Show Error Toast"),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                 CalenderResponseEvents.selectDateWithDatePicker(context,DateTime.now()).then((value) {
                   print(value);
                 });
                },
                child: Center(
                  child: Text("Open Date Picker"),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  CalenderResponseEvents.getTimeWithTimePicker(TimeOfDay.now(),context).then((value) {
                    print(value);
                  });
                },
                child: Center(
                  child: Text("Open Time Picker"),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  ImageManager.pickSingleImageThroughGallery("http://api.bmf.avinashi.com/api/v1/upload/profile/ec2bb7e72b8ab6166e23e950277725a4","profile",context).then((value) {
                    print(value);
                  });
                },
                child: Center(
                  child: Text("Pick Single Image Through Gallery"),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  ImageManager.pickSingleImageThroughCamera("http://api.bmf.avinashi.com/api/v1/upload/profile/ec2bb7e72b8ab6166e23e950277725a4","profile",context).then((value) {
                    print(value);
                  });
                },
                child: Center(
                  child: Text("Pick Single Image Through Camera"),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  ImageManager.getMultipleImageAssets("http://api.bmf.avinashi.com/api/v1/upload/multiple/attachments","icons[]",context).then((value) {
                    print(value);
                  });
                },
                child: Center(
                  child: Text("Multiple Images"),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpWithEmailScreen(
                      appIcon: Image(image: AssetImage('assets/logo.png'),height: 150.0),
                    afterSignUpCallback: signupResponse,
                  )));
                },
                child: Center(
                  child: Text("Sign In With Email"),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreviewScreen(
                    imageUrls: ["https:\/\/api.bmf.avinashi.com\/profile\/5dae934b5930e63022b025393cce4ab1-profile.jpg",
                      "https:\/\/api.bmf.avinashi.com\/profile\/b67dfbba16b34b9e11605d26a2901ad5-profile.jpg"],
                    title: "Images",
                  )));
                },
                child: Center(
                  child: Text("View All Images"),
                ),
              ),
                SizedBox(height: 30,),
//                GestureDetector(
//                  behavior: HitTestBehavior.opaque,
//                  onTap: () {
//                    GPSReading.getLocation().then((value) async {
//                      address = value;
//                      HttpLink httpLink =
//                      HttpLink(uri: 'https://gql.attendance.rajwafers.anant.io/v1/graphql', headers: {
//                        'x-hasura-admin-secret': graphQLObjectProvider.admin_secret_key,
//                      });
//
//                      final Link link = httpLink as Link;
//
//                      ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(
//                        GraphQLClient(
//                          cache: InMemoryCache(),
//                          link: link,
//                        ),
//                      );
//                      var client = clientNotifier.value;
//                      var queryResult = await client.mutate(
//                          MutationOptions(
//                            fetchPolicy: FetchPolicy.cacheAndNetwork,
//                            documentNode: gql(addGPSData()), // this is the mutation string you just created
//                            // you can update the cache based on results
//                            update: (Cache cache, QueryResult result) {
//                              final key = QueryOptions(
//                                documentNode: gql(addGPSData()),
//                              ).toKey();
//                              final data = cache.read(key);
//                              print(data);
//                              return cache;
//                            },
//                            // or do something with the result.data on completion
////                              onCompleted: (dynamic resultData) {
////                                print(resultData);
////                              },
//                          )
//                      );
//
//                      print(queryResult.data);
//
//                    });
//                  },
//                  child: Center(
//                    child: Text("GPS Punching"),
//                  ),
//                ),
              SizedBox(height: 30,),
              CommonWidget.getCacheNetworkImage("https:\/\/api.bmf.avinashi.com\/profile\/5dae934b5930e63022b025393cce4ab1-profile.jpg",context,300.0)
              ],
            ),
          ),
        ),
      );
  }

}
