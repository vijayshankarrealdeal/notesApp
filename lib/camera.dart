import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraAndFile extends ChangeNotifier{
  File resource ;
  Future<File> pickImage(BuildContext context,ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(
      source: source,
      maxHeight: MediaQuery.of(context).size.height * 0.85,
    );
    return selected;
  }
  ///setImageUsing Camera or Gallery.....
  Future<void> setImageI(BuildContext context,String xst,)async
  {
    final image =xst == "Camera"? await pickImage(context,ImageSource.camera):await pickImage(context,ImageSource.gallery);
    resource = image;
    notifyListeners();
  }
  /// call Pop up Menu
  void showListI(
      BuildContext context,
      CameraAndFile imagesFunction,
      ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: CupertinoActionSheet(
            title: Text('Notes'),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  await imagesFunction.setImageI(context,'Camera');
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  await imagesFunction.setImageI(context,'Gallery');
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              )
            ],
            cancelButton: CupertinoButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        );
      },
    );
  }

  void removeImageI()
  {
    resource = null;
    notifyListeners();
  }
  ///compress Each Image
  Future<void>compressImage(String id) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(resource.readAsBytesSync());
    final compressedImageFile = File('$path/img_$id.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
    resource =  compressedImageFile;
    notifyListeners();
  }
}
