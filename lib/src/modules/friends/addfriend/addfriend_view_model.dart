import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';

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
    required Friend friend,
    required String friendId,
  }) {
    final enteredText = titleController.text;
    if (!enteredText.isEmpty) {
      ref
          .read(friendProvider.notifier)
          .tryEditFriend(friend.id.toString(), enteredText);
      
    }
  }
}
