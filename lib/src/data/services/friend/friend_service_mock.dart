import 'dart:convert';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/services/friend/friend_service_interface.dart';

class FriendMockService implements FriendServiceInterface {
  List<Friend> mockFriend = [
    Friend(
      title: 'Jack',
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
    Friend(
      title: 'Jane',
      qrcode: [],
    ),
  ];

  @override
  Future<List<Friend>> addFriend(String name) async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> editFriend(String friendID, String newName) async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> deleteFriend(Friend friend)async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> addQrcode(Friend friend, QrCode qrcode) async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> editQrcode(Friend friend, QrCode qrcode) async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> deleteQrcode(Friend friend, QrCode qrcode) async {
    return mockFriend;
  }

  @override
  Future<List<Friend>> loadUser() async {
    return mockFriend;
  }
}