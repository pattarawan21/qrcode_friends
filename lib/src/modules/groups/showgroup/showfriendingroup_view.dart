import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/showqrcode/showqrcodelist_view.dart';

class ShowFriendinGroupScreen extends ConsumerStatefulWidget {
  final String? id;
  const ShowFriendinGroupScreen({super.key, required this.id});

  @override
  ConsumerState<ShowFriendinGroupScreen> createState() {
    return _ShowFriendinGroupScreenState();
  }
}

class _ShowFriendinGroupScreenState extends ConsumerState<ShowFriendinGroupScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends in Group'),
      ),
      body: FutureBuilder<List<Friend>> (
        future: ref.read(groupFriendProvider.notifier).tryGetFriendsInGroup(widget.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child:  Text('No friends in group'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowQrcodeListView(friend: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
