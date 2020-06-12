
import 'dart:io';

import 'package:boilerplate/CommonToastUI/ToastMessage.dart';
import 'package:boilerplate/Theme/AppTheme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:boilerplate/APICalls/ServerCommunicator.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageManager{

  static final picker = ImagePicker();
  static File _image;

  static pickSingleImageThroughGallery(String uploadImageURL, String uploadImageKey,BuildContext context) async {
    var image = await picker.getImage(
      source: ImageSource.gallery,
    );
    _image = File(image.path);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: DesignCourseAppTheme.appThemeColor,
            statusBarColor:DesignCourseAppTheme.appThemeColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    _image = croppedFile;

    var documentResponse = await APIProvider().uploadSingleImage(_image, uploadImageURL,uploadImageKey);
    if (documentResponse["flag"] == true) {
      return documentResponse["data"]["url"];
    } else {
      return Toast.show(documentResponse["message"], context);
    }
  }

  static pickSingleImageThroughCamera(String uploadImageURL, String uploadImageKey,BuildContext context) async {
    var image = await picker.getImage(
      source: ImageSource.camera,
    );

    _image = File(image.path);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: DesignCourseAppTheme.appThemeColor,
            statusBarColor:DesignCourseAppTheme.appThemeColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    _image = croppedFile;

    var documentResponse = await APIProvider().uploadSingleImage(_image, uploadImageURL,uploadImageKey);
    if (documentResponse["flag"] == true) {
      return documentResponse["data"]["url"];
    } else {
      return Toast.show(documentResponse["message"], context);
    }
  }

  static getMultipleImageAssets(String uploadImageURL, String uploadImageKey,BuildContext context) async {
    var assetPathList = await PhotoManager.getAssetPathList();
    var imgList = await PhotoPicker.pickAsset(
      context: context,
      themeColor: DesignCourseAppTheme.appThemeColor,
      textColor: Colors.white,
      padding: 1.0,
      dividerColor: Colors.grey,
      disableColor: Colors.grey.shade300,
      itemRadio: 0.88,
      maxSelected: 15,
      provider: I18nProvider.english,
      rowCount: 3,
      thumbSize: 150,
      sortDelegate: SortDelegate.common,
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Colors.white,
        checkColor: Colors.green,
      ),
      badgeDelegate: const DurationBadgeDelegate(),
      pickType: PickType.onlyImage,
      photoPathList: assetPathList,
    );

    List<MultipartFile> uploadFiles = [];

    if (imgList == null) {
    } else {
      List<File> files = [];
      for (var e in imgList) {
        var file = await e.file;
        files.add(file);
      }


      for (var img in files) {
        var file = await MultipartFile.fromFile(
            img.path, filename: img.path);
        uploadFiles.add(file);
      }
    };

      if (uploadFiles.length > 0) {
        var documentResponse = await APIProvider().uploadMultipleImages(uploadFiles, uploadImageURL,uploadImageKey);
        if(documentResponse != null){
          if (documentResponse["flag"] == true) {
            return documentResponse["data"];
          } else {
            return Toast.show(documentResponse["message"], context);
          }
        }
      }
    }
}