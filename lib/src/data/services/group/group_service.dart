import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/data/services/group/group_service_interface.dart';
import 'package:uuid/uuid.dart';

class GroupService implements GroupServiceInterface {
  @override
  Future <Map<String,dynamic>> addGroupFriend(String title) async {
  String newGroupId = Uuid().v4(); 
  GroupFriend newGroup = GroupFriend(id: newGroupId, title: title, listfriend: []);
  final box = await Hive.openBox<GroupFriend>('groupFriend');
  box.put(newGroupId, newGroup);
  return {'id': newGroupId, 'title': title, 'state': box.values.toList()} as Map<String, dynamic>;
  }
  @override
  Future<List<GroupFriend>> loadUser() async {
    return Hive.box<GroupFriend>('groupFriend').values.toList();
  }
  @override

  Future<List<GroupFriend>> addFriendToGroup(String groupId, List<Friend> newList) async {
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
        return box.values.toList();
    }
    return [];
  }
  @override
  Future<List<GroupFriend>> editGroupFriend(String groupfriendID, String newName) async {
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
    return box.values.toList();
  }
  @override
  Future<List<Friend>> getFriendsInGroup(String id) async {
    final box = await Hive.openBox<GroupFriend>('groupFriend');
  GroupFriend? group = box.get(id);
  if (group != null) {
    return group.listfriend;
  } else {
    return [];
  }
  }
  @override
  Future<List<GroupFriend>> deleteGroupFriend(GroupFriend friend) async {
    final box = await Hive.openBox<GroupFriend>('groupfriend');
    final index = box.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      await box.deleteAt(index);
      return box.values.toList();
    }
    return [];
  }
}