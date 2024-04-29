import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/modules/groups/addgroup/addgroup_view.dart';

class AddGroupViewModel{
  static void saveGroup({
  required BuildContext context,
  required WidgetRef ref,
  required List<Friend> friendsToAdd,
  required TextEditingController titleController,
}) async {
  final enteredText = titleController.text;
  String groupID = '';
  if (!enteredText.isEmpty)  {
    groupID = await  ref.read(groupFriendProvider.notifier).tryAddGroupFriend(enteredText);
  
    ref.read(groupFriendProvider.notifier).tryAddFriendToGroup(
      groupID,
      friendsToAdd,
    );
  }
    Navigator.of(context).pop();
}
   static void editNameGroup({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController titleController,
    required AddGroupViewScreen widget,
  }) {
    final enteredText = titleController.text;
    if (!enteredText.isEmpty) {
      ref
          .read(groupFriendProvider.notifier)
          .tryEditGroupFriend(widget.editName!.id.toString(), enteredText);
      Navigator.of(context).pop();
    }
  }
 
}