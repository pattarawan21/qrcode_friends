import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/addqrcode/addqrcode_view.dart';
import 'package:qrcode_fr/src/modules/qrcodes/showqrcode/showqrcode_view.dart';



class ShowQrcodeListView extends ConsumerStatefulWidget {
  final Friend friend;

  const ShowQrcodeListView ({super.key,required this.friend});

  @override
  ConsumerState<ShowQrcodeListView  > createState() => _ShowQrcodeListViewState();
}

class _ShowQrcodeListViewState extends ConsumerState<ShowQrcodeListView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr Codes "),
        actions: [
          IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddQrcodeView(friend: widget.friend),
                      ),
                    );
                  },
                ),
        ],
      ),
    
      body: Consumer(builder: (context, watch, child) {
        final qrCode = ref
            .watch(friendProvider)
            .where((element) => element.id == widget.friend.id)
            .first
            .qrcode;
        if (qrCode.isEmpty) {
          return Center(
            child: Text(
              "No Qr Codes. Please add.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          );
        }
        return ListView.builder(
                itemCount: qrCode.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.onPrimary,
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.4),
                            ],
                          ),
                        ),
                        child: ListTile(
                          title: Text(qrCode[index].title),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                               IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) => AddQrcodeView(
                                                      friend: widget.friend,
                                                      editQrcode:
                                                          qrCode[index],
                                                    )),
                                          );
                                        },
                                      ),
                               IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          ref
                                              .read(friendProvider.notifier)
                                              .tryDeleteQrcode(
                                                  widget.friend, qrCode[index]);
                                        }),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    QrcodeViewScreen(qrcodeDetails: qrCode[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
              );
      }),
    );
  }
}