import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_fr/models/friends.dart';

class GroupFriendNotifier extends StateNotifier<List<GroupFriend>> {
  GroupFriendNotifier() : super([]) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = Hive.box<GroupFriend>('groupFriend').values.toList();
  }

  final Box<GroupFriend> groupfriends = Hive.box<GroupFriend>('groupFriend');

  void addGroupFriend(String name) async {
    final box = await Hive.openBox<GroupFriend>('groupFriend');
    final groupfriend = GroupFriend(title: name);
    box.add(groupfriend);
    state = [...state, groupfriend];
  }

  void editGroupFriend(String groupfriendID, String newName) async {
    final box = await Hive.openBox<GroupFriend>('groupfriend');
    final index = box.values.toList().indexWhere((e) => e.id == groupfriendID);
    if (index >= 0) {
      final oldgroup = box.getAt(index);
      final updatefriend = GroupFriend(
        id: groupfriendID,
        title: newName,
        listfriend: oldgroup!.listfriend,
      );
      await box.putAt(index, updatefriend);
    }
    state = box.values.toList();
  }

  Future deleteFriend(GroupFriend friend) async {
    final box = await Hive.openBox<GroupFriend>('groupfriend');
    final index = state.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      await box.deleteAt(index);
      state = box.values.toList();
    }
  }
}

  final groupFriendProvider =
    StateNotifierProvider<GroupFriendNotifier, List<GroupFriend>>(
        (ref) => GroupFriendNotifier());