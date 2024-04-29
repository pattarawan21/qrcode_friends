import 'dart:convert';

import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/data/services/group/group_service_interface.dart';

class GroupMockService implements GroupServiceInterface{
  List<GroupFriend> mockGroup = [
    GroupFriend(
      title: 'Jack',
      listfriend: [
          Friend(
            title: '000000',
            qrcode: [
              QrCode(
                title: '000000',
                imagebytes: base64Decode('assets/images/john_doe.png'),
              ),
              QrCode(
                title: '000000',
                imagebytes: base64Decode('assets/images/john_doe.png'),
              ),
            ],
          ),
          Friend(
            title: 'Jack',
            qrcode: [
              QrCode(
                title: '1234',
                imagebytes: base64Decode('assets/images/john_doe.png')
              ),
              QrCode(
                title: 'Jack',
                imagebytes: base64Decode('assets/images/john_doe.png'),
              ),
            ],
          ),
          Friend(
            title: 'Jack',
            qrcode: [
              QrCode(
                title: 'Jack',
                imagebytes: base64Decode('assets/images/john_doe.png')
              ),
              QrCode(
                title: 'Jack',
                imagebytes: base64Decode('assets/images/john_doe.png')
              ),
            ],
          ),
          Friend(
            title: 'Jack',
            qrcode: [
              QrCode(
                title: 'Jack',
                imagebytes: base64Decode('assets/images/john_doe.png'),
              ),
              QrCode(
                title: 'Jack',
                imagebytes: base64Decode('assets/images/john_doe.png'),
              ),
            ],
          ),
          Friend(
            title: 'Jane',
            qrcode: [],
        ),
      ],
    ),
  ];

  @override
  Future<Map<String, dynamic>> addGroupFriend(String title) async {
    final newGroup = GroupFriend(title: title);
    mockGroup.add(newGroup);
    return {'state': mockGroup, 'id': newGroup.id};
  }

  @override
  Future<List<GroupFriend>> addFriendToGroup(String groupId, List<Friend> newList) async {
    final index = mockGroup.indexWhere((e) => e.id == groupId);
    if (index >= 0) {
      mockGroup[index].listfriend = newList;
    }
    return mockGroup;
  }

   @override
  Future<List<GroupFriend>> deleteGroupFriend(GroupFriend friend) async {
    mockGroup.removeWhere((e) => e.id == friend.id);
    return mockGroup;
  }
    @override
  Future<List<GroupFriend>> editGroupFriend(String groupfriendID, String newName) async {
    return mockGroup;
  }
    @override
  Future<List<Friend>> getFriendsInGroup(String id) async {
    final index = mockGroup.indexWhere((e) => e.id == id);
    if (index >= 0) {
      return mockGroup[index].listfriend;
    }
    return [];
  }
    @override
  Future<List<GroupFriend>> loadUser() async {
    return mockGroup;
  }
}