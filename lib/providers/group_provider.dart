import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_fr/models/friends.dart';
import 'package:uuid/uuid.dart';

class GroupFriendNotifier extends StateNotifier<List<GroupFriend>> {
  GroupFriendNotifier() : super([]) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = Hive.box<GroupFriend>('groupFriend').values.toList();
  }

  final Box<GroupFriend> groupfriends = Hive.box<GroupFriend>('groupFriend');

  // void addGroupFriend(String name) async {
  //   final box = await Hive.openBox<GroupFriend>('groupFriend');
  //   final groupfriend = GroupFriend(title: name);
  //   box.add(groupfriend);
  //   state = [...state, groupfriend];
  // }
  Future<String> addGroupFriend(String title) async {
  // Generate a new ID for the group
  String newGroupId = Uuid().v4(); // Using the uuid package to generate a unique ID

  // Create a new group with the entered title and the new ID
  GroupFriend newGroup = GroupFriend(id: newGroupId, title: title, listfriend: []);

  // Add the new group to the state and the Hive box
  state = [...state, newGroup];
  final box = await Hive.openBox<GroupFriend>('groupFriend');
  box.put(newGroupId, newGroup);

  // Return the new group id
  return newGroupId;
}

 void addFriendToGroup(String groupId, List<Friend> newList) async {
  final box = await Hive.openBox<GroupFriend>('groupFriend');
  final index =
        box.values.toList().indexWhere((g) => g.id == groupId);
  if (index != -1) {
    final oldData = box.getAt(index);
      final updatedGroup = GroupFriend(
        id: groupId,
        title: oldData!.title,
        listfriend: newList,
      );
      await box.putAt(index, updatedGroup);
      state = box.values.toList();
  }
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

  Future deleteGroupFriend(GroupFriend friend) async {
    final box = await Hive.openBox<GroupFriend>('groupfriend');
    final index = state.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      await box.deleteAt(index);
      state = box.values.toList();
    }
  }
}
Future<List<Friend>> getFriendsInGroup(String id) async {
  final box = await Hive.openBox<GroupFriend>('groupFriend');
  GroupFriend? group = box.get(id);

  if (group != null) {
    return group.listfriend;
  } else {
    return [];
  }
}

  final groupFriendProvider =
    StateNotifierProvider<GroupFriendNotifier, List<GroupFriend>>(
        (ref) => GroupFriendNotifier());