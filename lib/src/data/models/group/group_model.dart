import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/services/group/group_service.dart';
import 'package:qrcode_fr/src/data/services/group/group_service_interface.dart';
import 'package:uuid/uuid.dart';  

part 'group_model.g.dart';
const  uuid = Uuid();

@HiveType(typeId: 3)
class GroupFriend {
  GroupFriend({
    required this.title,
    String? id,
    List<Friend>? listfriend
  }) : id = id ?? uuid.v4(),
    listfriend = listfriend ?? [];
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  List<Friend> listfriend;
}

final GroupServiceInterface _groupService = GroupService();

class GroupFriendNotifier extends StateNotifier<List<GroupFriend>> {
  GroupFriendNotifier() : super([]) {
    _loadUser();
  }
    Future<void> _loadUser() async {
    state = await _groupService.loadUser();
  }

  void tryAddGroupFriend(String title) async {
    //state = await _groupService.addGroupFriend(title) 
    Map<String, dynamic> result = await _groupService.addGroupFriend(title);
    state = result['state'] as List<GroupFriend>;

  }

  void tryAddFriendToGroup(String groupId, List<Friend> newList) async {
    state = await _groupService.addFriendToGroup(groupId, newList);
  }
  
  void tryEditGroupFriend(String groupfriendID, String newName) async {
    state = await _groupService.editGroupFriend(groupfriendID, newName);
  }

  Future<List<Friend>> tryGetFriendsInGroup(String id) async {
    return await _groupService.getFriendsInGroup(id);
  }

  void tryDeleteGroupFriend(GroupFriend friend) async {
    state = await _groupService.deleteGroupFriend(friend);
  }
}
final groupFriendProvider =
    StateNotifierProvider<GroupFriendNotifier, List<GroupFriend>>(
        (ref) => GroupFriendNotifier());