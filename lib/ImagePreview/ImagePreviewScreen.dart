import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewScreen extends StatefulWidget {
  List<String> imageUrls;
  String title;

  ImagePreviewScreen(
      {Key key, @required this.imageUrls, @required this.title})
      : super(key: key);

  @override
  ImagePreviewScreenState createState() {
    return new ImagePreviewScreenState(imageUrls: imageUrls, title: title);
  }
}

class ImagePreviewScreenState extends State<ImagePreviewScreen> {
  List<String> imageUrls;
  List<CachedNetworkImageProvider> imageProviders = [];
  String title;
  String imageCaption = "";
  int currentIndex;
  var intdex1 = 0;
  ImagePreviewScreenState({Key key, @required this.imageUrls, @required this.title});

  PhotoViewGalleryPageOptions getImageView(CachedNetworkImageProvider image, int index) {
    return PhotoViewGalleryPageOptions(
        basePosition: Alignment.center,
//        minScale: PhotoViewComputedScale.covered * 0.5,
        imageProvider: image);
//        heroTag: index.toString());
  }

  @override
  void initState() {
    currentIndex = intdex1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var configuration = createLocalImageConfiguration(context);
    imageUrls.forEach((eachImage){
      final networkImageProvider = CachedNetworkImageProvider(
        "https://thumbor.avinashi.com/unsafe/0x0/filters:quality(100)/" +
            eachImage,)
        ..resolve(configuration);
      imageProviders.add(networkImageProvider);
    });
    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: Color.fromRGBO(220, 242, 248, 1.0),
//        elevation: 0.0,
//        leading: new Container(
//          child: IconButton(
//            icon: Icon(Icons.arrow_back,color: Colors.black,),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//          ),
//        ),
//        title: new Text(
//          title == null ? "Images" : title,
//          style: TextStyle(
//            fontSize: 20,
//            color: Colors.black
//          ),
//        ),
//        centerTitle: false,
//        titleSpacing: 0.0,
//      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                constraints: BoxConstraints.expand(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      customSize: Size.fromHeight(MediaQuery.of(context).size.height),
                      builder: (context, index) {
                        intdex1 = index;
                        return getImageView(imageProviders[index], index);
                      },
                      itemCount: imageUrls.length,
                      loadingChild: SpinKitThreeBounce(
                        color: Color.fromRGBO(220, 242, 248, 1.0),
                        size: 30.0,
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      pageController: PageController(initialPage: intdex1),
                      onPageChanged: onPageChanged,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x00000000),
                            const Color(0xDD000000),
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              " ${currentIndex + 1}" + "/" +
                                  imageUrls.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
              top: 20,left: 5,
              child: Container(
                  height: 50,width: 50,
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
//                          color: Color.fromRGBO(191, 191, 193, 0.5),
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  )
              ),
            ),

          ],

        ),
      ),
    );
  }
}
