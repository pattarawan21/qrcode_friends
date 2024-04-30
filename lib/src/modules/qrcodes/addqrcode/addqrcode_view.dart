import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/common/constants/icon_constant.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/addqrcode/addqrcode_view_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/qrimage/qrimage_view.dart';




class AddQrcodeView extends ConsumerStatefulWidget {
  final QrCode? editQrcode;
  final bool isEdit;
  final Friend friend;
  const AddQrcodeView(
      {super.key, required this.friend, this.editQrcode, this.isEdit = false});
  @override
  ConsumerState<AddQrcodeView> createState() => _AddQrcodeView();
}

class _AddQrcodeView extends ConsumerState<AddQrcodeView> {
  var titleController = TextEditingController();
  File? _selectedImage;
    void initState()  {
    super.initState();
    titleController =
        TextEditingController(text: widget.editQrcode?.title ?? '');
        if (widget.editQrcode?.imagebytes != null) {
      AddQrcodeViewModel.convertUint8ListToFile(widget.editQrcode!.imagebytes, 'qrcodeImage.jpg').then((File file) {
        setState(() {
          _selectedImage = file;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editQrcode != null
              ? "Edit Qr Code : ${widget.editQrcode?.title}"
              : "Add Qr Code : ${widget.friend.title}",
        ),
        actions: [
          widget.isEdit
              ? const SizedBox()
              : IconButton(
                  icon: IconConstant().iconSave,
                  iconSize: 30,
                  onPressed: () {
                    if (widget.editQrcode == null) {
                      AddQrcodeViewModel.saveQrcode(
                          ref: ref,
                          titleController: titleController,
                          widget: widget,
                          selectedImage: _selectedImage);
                      Navigator.of(context).pop();
                    } else {
                      AddQrcodeViewModel.editQrcode(
                          ref: ref,
                          titleController: titleController,
                          widget: widget,
                          selectedImage: _selectedImage);
                      Navigator.of(context).pop();
                    }
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: const InputDecoration(
                  labelText: 'Accout Name',

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // add box to add image
              QrimageView(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                  qrimage: _selectedImage),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


}
