import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/modules/groups/addgroup/addgroup_view_model.dart';


class MockWidgetRef extends Mock implements WidgetRef {}
class MockTextEditingController extends Mock implements TextEditingController {}
class MockGroupFriendNotifier extends Mock implements GroupFriendNotifier {}

void main() {
  late MockGroupFriendNotifier mockGroupFriendNotifier;
  late MockWidgetRef mockRef;
  late MockTextEditingController mockController;
  setUp(() {
    mockRef = MockWidgetRef();
    mockController = MockTextEditingController();
    mockGroupFriendNotifier = MockGroupFriendNotifier();
    when(() => mockRef.read(groupFriendProvider.notifier)).thenReturn(mockGroupFriendNotifier);
    when(() => mockController.text).thenReturn( 'test');
  });
  group('AddGroupViewModel', () {
    test('saveGroup should call tryAddGroupFriend with entered text', () async {
      when(() => mockController.text).thenReturn('test');
      when(() => mockRef.read(groupFriendProvider.notifier)).thenReturn(mockGroupFriendNotifier);
      when(() => mockGroupFriendNotifier.tryAddGroupFriend('test')).thenAnswer((_) async => '1');
      when(() => mockGroupFriendNotifier.tryAddFriendToGroup(any(), any())).thenAnswer((_) async {});

     await AddGroupViewModel.saveGroup(
        ref: mockRef,
        friendsToAdd: [],
        titleController: mockController,
      );
      verify(() => mockGroupFriendNotifier.tryAddGroupFriend('test')).called(1);
      verify(() => mockGroupFriendNotifier.tryAddFriendToGroup(any(), any())).called(1);
    });

  test('saveGroup should call tryAddFriendtoGroup with entered text', () async {
  when(() => mockController.text).thenReturn('test');
  when(() => mockRef.read(groupFriendProvider.notifier)).thenReturn(mockGroupFriendNotifier);
  when(() => mockGroupFriendNotifier.tryAddGroupFriend('test')).thenAnswer((_) async => '1');
  when(() => mockGroupFriendNotifier.tryAddFriendToGroup('1',[Friend(id: '1', title: 'test')] )).thenAnswer((_) async {[Friend(id: '1', title: 'test')];});

  String groupId = await mockGroupFriendNotifier.tryAddGroupFriend('test');

  await AddGroupViewModel.saveGroup(
    ref: mockRef,
    friendsToAdd: [Friend(id: '1', title: 'test')],
    titleController: mockController,
  );
  verify(() => mockGroupFriendNotifier.tryAddFriendToGroup(groupId, any())).called(1);
});


    test('editNameGroup should not call tryEditGroupFriend with no entered text', () async {
      when(() => mockController.text).thenReturn('');
      AddGroupViewModel.editNameGroup(
        ref: mockRef,
        titleController: mockController,
        groupfriend: GroupFriend(id: '1', title: 'test'),
        groupId: '1',
      );
      verifyNever(() => mockGroupFriendNotifier.tryEditGroupFriend(any(), any()));
    });

    test('editNameGroup should call tryEditGroupFriend with entered text', () async {
      AddGroupViewModel.editNameGroup(
        ref: mockRef,
        titleController: mockController,
        groupfriend: GroupFriend(id: '1', title: 'test'),
        groupId: '1',
      );
      verify(() => mockGroupFriendNotifier.tryEditGroupFriend('1', 'test')).called(1);
    });
  });

}