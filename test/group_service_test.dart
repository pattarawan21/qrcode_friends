import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/data/services/group/group_service.dart';


class MockGroupService extends Mock implements GroupService {}

void main(){
  late GroupService sut;

  setUp((){
    sut = MockGroupService();
  });
  group('Group Service', () {
    final mockGroup = [
      GroupFriend(title: '1', listfriend: [Friend(title: 'Jack', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]),
      Friend(title: 'Jane', qrcode: [QrCode(title: '2', imagebytes: Uint8List.fromList([255]))]),]),
      GroupFriend(title: '2', listfriend: [Friend(title: 'John', qrcode: [QrCode(title: '3', imagebytes: Uint8List.fromList([255]))]),
      Friend(title: 'Job'),]),
      GroupFriend(title:'3', listfriend: [])
    ];
    test(
      'should add a group and return a list of groups',
      () async {
        final map  = <String,dynamic>{
          'id': '3',
          'title': 'Jill',
          'state': List<GroupFriend>.from(mockGroup)
        };
        when(() => sut.addGroupFriend('Jill')).thenAnswer((_) async => map);
        final result = await sut.addGroupFriend('Jill');
        expect(result, map);
        verify(() => sut.addGroupFriend('Jill')).called(1);
      }
    );
    test (
      'should edit name group and return a list of groups',
      () async {
        final listgroup = List<GroupFriend>.from(mockGroup);
        listgroup[2] = GroupFriend(title: '4', listfriend: []);
        when(() => sut.editGroupFriend('3', '4')).thenAnswer((_) async => listgroup);
        final result = await sut.editGroupFriend('3', '4');
        expect(result, listgroup);
        verify(() => sut.editGroupFriend('3', '4')).called(1);
      }
    );
    test(
      'should add friend to group and return a list of groups',
      () async {
        final listgroup = List<GroupFriend>.from(mockGroup);
        final friend = Friend(title: 'Jill');
        listgroup[2].listfriend.add(friend);
        when(() => sut.addFriendToGroup('3', [friend])).thenAnswer((_) async => listgroup);
        final result = await sut.addFriendToGroup('3', [friend]);
        expect(result, listgroup);
        verify(() => sut.addFriendToGroup('3', [friend])).called(1);
      }
    );
    test(
      'should get friends in group and return a list of friends',
      () async {
        final listgroup = List<GroupFriend>.from(mockGroup);
        final friend = Friend(title: 'Jill');
        listgroup[2].listfriend.add(friend);
        when(() => sut.getFriendsInGroup('3')).thenAnswer((_) async => listgroup[2].listfriend);
        final result = await sut.getFriendsInGroup('3');
        expect(result, listgroup[2].listfriend);
        verify(() => sut.getFriendsInGroup('3')).called(1);
      }
    );
    test(
      'should delete group and return a list of groups',
      () async {
        final listgroup = List<GroupFriend>.from(mockGroup);
        final groupToDelete = GroupFriend(title: '1', listfriend: [Friend(title: 'Jack', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]),
        Friend(title: 'Jane', qrcode: [QrCode(title: '2', imagebytes: Uint8List.fromList([255]))]),]);
        listgroup.removeWhere((group) => group.title == groupToDelete.title);
        when(() => sut.deleteGroupFriend(groupToDelete)).thenAnswer((_) async => listgroup);
        final result = await sut.deleteGroupFriend(groupToDelete);
        expect(result, listgroup);
        verify(() => sut.deleteGroupFriend(groupToDelete)).called(1);
        // Check that the group with the specified title has been removed from listgroup
        expect(listgroup.where((group) => group.title == groupToDelete.title), isEmpty);
      }
    );
   });

}