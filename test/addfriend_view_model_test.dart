import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/friends/addfriend/addfriend_view_model.dart';

class MockWidgetRef extends Mock implements WidgetRef {}
class MockTextEditingController extends Mock implements TextEditingController {}
class MockFriendNotifier extends Mock implements FriendNotifier {}


void main() {
  late MockFriendNotifier mockFriendNotifier;
  late MockWidgetRef mockRef;
  late MockTextEditingController mockController;
  setUp(() {
    mockRef = MockWidgetRef();
    mockController = MockTextEditingController();
    mockFriendNotifier = MockFriendNotifier();
    when(() => mockRef.read(friendProvider.notifier)).thenReturn(mockFriendNotifier);
    when(() => mockController.text).thenReturn( 'test friend');
  });
  group('AddFriendViewModel', () {
    test('saveFriend should call tryAddFriend with entered text', () {
      AddFriendViewModel.saveFriend(ref: mockRef, titleController: mockController);
      verify(() => mockRef.read(friendProvider.notifier).tryAddFriend('test friend')).called(1);
    });
 
  });
}