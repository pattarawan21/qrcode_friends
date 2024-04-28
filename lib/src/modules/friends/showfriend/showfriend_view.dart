import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/common/constants/icon_constant.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/friends/addfriend/addfriend_view.dart';
import 'package:qrcode_fr/src/modules/friends/showfriend/showfriend_view_model.dart';
import 'package:qrcode_fr/src/modules/groups/showgroup/showgroup_view.dart';



class ShowFriendViewScreen extends ConsumerStatefulWidget {
  const ShowFriendViewScreen({super.key});

  @override
  ConsumerState<ShowFriendViewScreen> createState() {
    return _ShowFriendViewScreenState();
  }
}

class _ShowFriendViewScreenState extends ConsumerState<ShowFriendViewScreen> {
  @override
  Widget build(BuildContext context) {
    final friendList = ref.watch(friendProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend"),
        actions: [
          IconButton(
            icon: IconConstant().iconAdd,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddFriendViewScreen()),
              );
            },
          ),
          IconButton(
            icon: IconConstant().iconPeople,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const GroupFriendViewScreen()),
              );
            },
          ),
        ],
      ),
      body: ShowFriendViewModel(friends: friendList,)
    );
  }
}
