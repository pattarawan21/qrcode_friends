import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/providers/friend_provider.dart';
import 'package:qrcode_fr/screens/add_friend.dart';
import 'package:qrcode_fr/widgets/friend_list.dart';

class FriendScreen extends ConsumerStatefulWidget {
  const FriendScreen({super.key});

  @override
  ConsumerState<FriendScreen> createState() {
    return _FriendScreenState();
  }
}

class _FriendScreenState extends ConsumerState<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    final friendList = ref.watch(FriendProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddFriendScreen()),
              );
            },
          ),
        ],
      ),
      body: FriendList(friendList),
    );
  }
}
