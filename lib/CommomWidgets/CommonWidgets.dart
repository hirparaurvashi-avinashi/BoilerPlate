import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonWidget{

  static Widget getCacheNetworkImage(String imageUrl,BuildContext context,double height){
    return  Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            child: ClipRRect(
                borderRadius: BorderRadius
                    .all(Radius
                    .circular(
                    00.0)),
                child:
                CachedNetworkImage(
                    imageUrl:
                    imageUrl,
                    fit: BoxFit
                        .cover,
                    imageBuilder:
                        (context,
                        imageProvider) =>
                        Container(
                          decoration:
                          BoxDecoration(
                            image:
                            DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    width: MediaQuery.of(
                        context)
                        .size
                        .width,
                    height: MediaQuery.of(
                        context)
                        .size
                        .width /
                        2,
                    placeholder:
                        (context,
                        dd) {
                      return Center(
                          child:
                          Container());
                    })),
          ),
        ],
      ),
    );
  }

  static Widget getSplashScreen(BuildContext context, Image appIcon){
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  appIcon,
                  SpinKitThreeBounce(
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                  )
                ],
              )),
        ],
      ),
    );
  }

}