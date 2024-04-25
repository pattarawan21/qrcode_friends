import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/models/friends.dart';
import 'package:qrcode_fr/providers/group_provider.dart';
import 'package:qrcode_fr/widgets/qr_list.dart';

class GroupFriendsScreen extends ConsumerStatefulWidget {
  final String? id;
  const GroupFriendsScreen({super.key, required this.id});

  @override
  ConsumerState<GroupFriendsScreen> createState() {
    return _GroupFriendsScreenState();
  }
}

class _GroupFriendsScreenState extends ConsumerState<GroupFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends in Group'),
      ),
      body: FutureBuilder<List<Friend>>(
        future: getFriendsInGroup(widget.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('No friends in group'));
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
                            QrList(friend: snapshot.data![index]),
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
