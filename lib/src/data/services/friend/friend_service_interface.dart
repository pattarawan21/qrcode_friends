

import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';

abstract class FriendServiceInterface {
  Future<List<Friend>> addFriend(String name);
  Future<List<Friend>> editFriend(String friendID, String newName);
  Future<List<Friend>> deleteFriend(Friend friend);
  Future<List<Friend>> addQrcode(Friend friend, QrCode qrcode);
  Future<List<Friend>> deleteQrcode(Friend friend, QrCode qrcode);
  Future<List<Friend>> loadUser();
  Future<List<Friend>> editQrcode(Friend friend, QrCode qrcode);
}