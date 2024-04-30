import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/friends/addfriend/addfriend_view.dart';

class AddFriendViewModel {
  static void saveFriend({
    required WidgetRef ref,
    required TextEditingController titleController,
  })  {

    final enteredText = titleController.text;
    if (!enteredText.isEmpty) {
      ref.read(friendProvider.notifier).tryAddFriend(enteredText);
    }
  }

  static void editNameFriend({
    required WidgetRef ref,
    required TextEditingController titleController,
    required AddFriendViewScreen widget,
  }) {
    final enteredText = titleController.text;
    if (!enteredText.isEmpty) {
      ref
          .read(friendProvider.notifier)
          .tryEditFriend(widget.editName!.id.toString(), enteredText);
      
    }
  }
}
