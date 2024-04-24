import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_fr/models/friends.dart';
import 'package:qrcode_fr/providers/friend_provider.dart';
import 'package:qrcode_fr/widgets/qr_image.dart';

class AddQrcode extends ConsumerStatefulWidget {
  final QrCode? editQrcode;
  final bool isEdit;
  final Friend friend;
  const AddQrcode(
      {super.key, required this.friend, this.editQrcode, this.isEdit = false});
  @override
  ConsumerState<AddQrcode> createState() => _AddQrcode();
}

class _AddQrcode extends ConsumerState<AddQrcode> {
  var nameController = TextEditingController();
  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.editQrcode?.title ?? '');
        if (widget.editQrcode?.imagebytes != null) {
      convertUint8ListToFile(widget.editQrcode!.imagebytes, 'tempImage.jpg').then((File file) {
        setState(() {
          _selectedImage = file;
        });
      });
    }
  }
  Future<File> convertUint8ListToFile(Uint8List data, String fileName) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath/$fileName');
  return file.writeAsBytes(data);
}
  void _saveQrcode() async {
    final name = nameController.text;
    final image = _selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    
    final newQr = QrCode(
      title: name,
      imagebytes: await image.readAsBytes(),
    );
    ref.read(FriendProvider.notifier).addQrcode(widget.friend, newQr);
    Navigator.of(context).pop();
  }
    void _editQrcode() async{
    final name = nameController.text;
    final image = _selectedImage;
    if (name.isEmpty || image == null) {
      return;
    }
    final myid = widget.editQrcode!.id;
    final newQr = QrCode(
      id: myid,
      title: name,
      imagebytes: await image.readAsBytes(),
    );
    ref.read(FriendProvider.notifier).editQrcode(widget.friend, newQr);
    Navigator.of(context).pop();
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
                  icon: const Icon(Icons.save),
                  iconSize: 30,
                  onPressed:
                      widget.editQrcode == null ? _saveQrcode : _editQrcode,
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
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
              PickedQr(
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
    nameController.dispose();
    super.dispose();
  }


}
