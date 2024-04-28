import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode_fr/src/modules/qrcodes/qrimage/qrimage_view.dart';

class QrimageViewModel{
    void takePhoto({required QrimageView widget,required File? image}) async{
    final qrpicker = ImagePicker();
    final pickimage = await qrpicker.pickImage(source: ImageSource.camera);
    if(pickimage == null){
      debugPrint('No image selected');
      return;
    }
    void setState(VoidCallback callback) {
    }
    setState(() {
        image = File(pickimage.path);
      });
      widget.onPickImage(image!);
  }
   void chooseImage({required QrimageView widget,required File? image} ) async {
    final qrpicker = ImagePicker();
    final selectedImage = await qrpicker.pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
    void setState(VoidCallback callback) {
    }
      setState(() {
        image = File(selectedImage.path);
      });
    widget.onPickImage(image!);
  }
}
// ทำ set state ไม่ได้