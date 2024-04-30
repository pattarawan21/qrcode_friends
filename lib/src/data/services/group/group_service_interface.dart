import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';

abstract class GroupServiceInterface {
  Future <Map<String,dynamic>>  addGroupFriend(String title); 
  Future<List<GroupFriend>> addFriendToGroup(String groupId, List<Friend> newList);
  Future<List<GroupFriend>> editGroupFriend(String groupfriendID, String newName);
  Future<List<Friend>> getFriendsInGroup(String id);
  Future<List<GroupFriend>> deleteGroupFriend(GroupFriend friend);
  Future<List<GroupFriend>> loadUser();
  }