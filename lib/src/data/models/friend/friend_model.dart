import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_fr/src/data/services/friend/friend_service.dart';
import 'package:qrcode_fr/src/data/services/friend/friend_service_interface.dart';
import 'package:uuid/uuid.dart';  

part 'friend_model.g.dart';

const  uuid = Uuid();


@HiveType(typeId: 1)
class Friend {
  Friend({
    required this.title,
    String? id,
    List<QrCode>? qrcode
  }) : id = id ?? uuid.v4(),
    qrcode = qrcode ?? [];
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String title;
  
  @HiveField(2)
  List<QrCode> qrcode = [];
}

@HiveType(typeId: 2)
class QrCode {
  QrCode({
    required this.imagebytes,
    required this.title,
    String? id
  }) : id = id ?? uuid.v4();

  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  Uint8List imagebytes;
}

class FriendNotifier extends StateNotifier<List<Friend>> {
  FriendNotifier() : super([]) {
    _loadUser();
  }

final FriendServiceInterface _friendService = FriendService();
  
  Future<void> _loadUser() async {
    state = await _friendService.loadUser();
  }

  void tryAddFriend(String name) async {
    state = await _friendService.addFriend(name);
  }

  void tryEditFriend(String friendID, String newName) async {
    state = await _friendService.editFriend(friendID, newName);
  }

  void tryDeleteFriend(Friend friend) async {
    state = await _friendService.deleteFriend(friend);
  }

  void tryAddQrcode(Friend friend, QrCode qrcode) async {
    state = await _friendService.addQrcode(friend, qrcode);
  }

  void tryDeleteQrcode(Friend friend, QrCode qrcode) async {
    state = await _friendService.deleteQrcode(friend, qrcode);
  }

  void tryEditQrcode(Friend friend, QrCode qrcode) async {
    state = await _friendService.editQrcode(friend, qrcode);
  }
}

final friendProvider =
    StateNotifierProvider<FriendNotifier, List<Friend>>(
        (ref) => FriendNotifier());
