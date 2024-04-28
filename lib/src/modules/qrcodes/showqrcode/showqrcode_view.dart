
import 'package:flutter/material.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';


class QrcodeViewScreen extends StatelessWidget {
  final QrCode qrcodeDetails;
  const QrcodeViewScreen({super.key, required this.qrcodeDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 400,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: Image.memory(
                (qrcodeDetails.imagebytes),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Account:",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            qrcodeDetails.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
  }
}
