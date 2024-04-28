import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/addqrcode/addqrcode_view.dart';

class AddQrcodeViewModel{

  static Future<File> convertUint8ListToFile(Uint8List data, String fileName) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath/$fileName');
  return file.writeAsBytes(data);
}
 static void saveQrcode({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController titleController,
    required AddQrcodeView widget,
    required File? selectedImage,
  })  async {
    final name = titleController.text;
    final image = selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    
    final newQr = QrCode(
      title: name,
      imagebytes: await image.readAsBytes(),
    );
    ref.read(friendProvider.notifier).tryAddQrcode(widget.friend, newQr);
    Navigator.of(context).pop();
  }
  static void editQrcode({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController titleController,
    required AddQrcodeView widget,
    required File? selectedImage,
  })  async{
    final name = titleController.text;
    final image = selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final newQr = QrCode(
      id: widget.editQrcode!.id,
      title: name,
      imagebytes: await image.readAsBytes(),
    );
    ref.read(friendProvider.notifier).tryEditQrcode(widget.friend, newQr);
    Navigator.of(context).pop();
  }

}