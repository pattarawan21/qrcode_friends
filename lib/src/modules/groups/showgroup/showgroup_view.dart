import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/common/constants/icon_constant.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/modules/groups/addgroup/addgroup_view.dart';
import 'package:qrcode_fr/src/modules/groups/showgroup/showlistgroup_view.dart';


class GroupFriendViewScreen extends ConsumerStatefulWidget {
  const GroupFriendViewScreen({super.key});

  @override
  ConsumerState<GroupFriendViewScreen> createState() {
    return _GroupFriendViewScreenState();
  }
}

class _GroupFriendViewScreenState extends ConsumerState<GroupFriendViewScreen> {
  @override
  Widget build(BuildContext context) {
    final groupfriendList = ref.watch(groupFriendProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Friend"),
        actions: [
          IconButton(
            icon: IconConstant().iconAdd,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddGroupViewScreen()),
              );
            },
          ),
        ],
      ),
       body: ShowListGroupFriendView(groupfriendList),
    );
  }
}
