import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/qrcodes/addqrcode/addqrcode_view_model.dart';

class MockWidgetRef extends Mock implements WidgetRef {}
class MockTextEditingController extends Mock implements TextEditingController {}
class MockFriend extends Mock implements Friend {}
class MockQrCode extends Mock implements QrCode {}
class MockFriendNotifier extends Mock implements FriendNotifier {}
class MockFile extends Mock implements File {}

void main() {
  late MockFriend mockFriend;
  late MockFile mockSelectedImage;
  late MockTextEditingController mockTitleController;
  late MockWidgetRef mockRef;
  late MockFriendNotifier mockFriendNotifier;

  setUpAll(() => {
    registerFallbackValue(MockFriend()),
    registerFallbackValue(MockQrCode()),
  });

  setUp(() => {
    mockFriend = MockFriend(),
    mockSelectedImage = MockFile(),
    mockTitleController = MockTextEditingController(),
    mockRef = MockWidgetRef(),
    mockFriendNotifier = MockFriendNotifier(),
  });
  group('AddQrcodeViewModel', () {
    test('saveQrcode should not call tryAddQrcode with no selected image', () async {
      when(() => mockRef.read(friendProvider.notifier)).thenReturn(mockFriendNotifier);
      when(() => mockTitleController.text).thenReturn('test qrcode');
  
  
       AddQrcodeViewModel.saveQrcode(
        ref: mockRef,
        titleController: mockTitleController,
        friend: mockFriend,
        selectedImage: null,
      );
      verifyNever(() => mockFriendNotifier.tryAddQrcode(any(), any()));
    });

    test('saveQrcode should  call tryAddQrcode with enteredtext and selected image', () async {
      when(() => mockRef.read(friendProvider.notifier)).thenReturn(mockFriendNotifier);
      when(() => mockTitleController.text).thenReturn('test qrcode');
      when(() => mockSelectedImage.readAsBytes()).thenAnswer((_) async => Uint8List.fromList([255]));
  
      await AddQrcodeViewModel.saveQrcode(
        ref: mockRef,
        titleController: mockTitleController,
        friend: mockFriend,
        selectedImage: mockSelectedImage,
      );
      verify(() => mockFriendNotifier.tryAddQrcode(mockFriend, any())).called(1);
    });

    test('editQrcode should call tryeditQrcode with enteredtext and select image', () async {
      when(() => mockRef.read(friendProvider.notifier)).thenReturn(mockFriendNotifier);
      when(() => mockTitleController.text).thenReturn('test qrcode');
      when(() => mockSelectedImage.readAsBytes()).thenAnswer((_) async => Uint8List.fromList([255]));
  
      await AddQrcodeViewModel.editQrcode(
        ref: mockRef,
        titleController: mockTitleController,
        friend: mockFriend,
        qrId: MockQrCode(),
        selectedImage: mockSelectedImage,
      );
      verify(() => mockFriendNotifier.tryEditQrcode(mockFriend, any())).called(1);
    });



  });
}