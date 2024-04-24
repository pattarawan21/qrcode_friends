import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedQr extends StatefulWidget {
  final File? qrimage;
  final bool isEdit;
  const PickedQr(
      {super.key,
      required this.onPickImage,
      this.qrimage,
      this.isEdit = false});
  final void Function(File image) onPickImage;
  @override
  State<PickedQr> createState() {
    return _PickQrState();
  }
}

class _PickQrState extends State<PickedQr> {
  File? _image;

  void _takePhoto() async{
    final qrpicker = ImagePicker();
    final pickimage = await qrpicker.pickImage(source: ImageSource.camera);
    if(pickimage == null){
      debugPrint('No image selected');
      return;
    }
    setState(() {
        _image = File(pickimage.path);
      });
      widget.onPickImage(_image!);
  }
  void _chooseImage() async {
    final qrpicker = ImagePicker();
    final selectedImage = await qrpicker.pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
      setState(() {
        _image = File(selectedImage.path);
      });
    widget.onPickImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          )),
          child: _image != null ?
             Image.file(
                  _image!,
                  scale: 1.0,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                )
          : const Center(child: Text('No image selected')),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.isEdit
                ? const SizedBox()
                : TextButton.icon(
                    onPressed: _chooseImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallery"),
                  ),
            widget.isEdit
                ? const SizedBox()
                : TextButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _image = widget.qrimage;
  }

}
