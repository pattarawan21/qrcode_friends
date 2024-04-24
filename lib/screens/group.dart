import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/providers/group_provider.dart';
import 'package:qrcode_fr/screens/add_group.dart';
import 'package:qrcode_fr/widgets/group_list.dart';

class GroupFriendScreen extends ConsumerStatefulWidget {
  const GroupFriendScreen({super.key});

  @override
  ConsumerState<GroupFriendScreen> createState() {
    return _GroupFriendScreenState();
  }
}

class _GroupFriendScreenState extends ConsumerState<GroupFriendScreen> {
  @override
  Widget build(BuildContext context) {
    final groupfriendList = ref.watch(groupFriendProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Friend"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddGroupScreen()),
              );
            },
          ),
        ],
      ),
       body: GroupList(groupfriendList),
    );
  }
}
