import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/services/friend/friend_service_interface.dart';

class FriendService implements FriendServiceInterface{
  @override
   Future<List<Friend>> loadUser() async {
    return Hive.box<Friend>('Friend').values.toList();
  }
  final Box<Friend> friends = Hive.box<Friend>('friend');
  @override
  Future<List<Friend>> addFriend(String name) async {
    final box = await Hive.openBox<Friend>('friend');
    final friend = Friend(title: name);
    box.add(friend);
    return box.values.toList();
  }
  @override
  Future<List<Friend>>  editFriend(String friendID, String newName) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = box.values.toList().indexWhere((e) => e.id == friendID);
    if (index >= 0) {
      final oldfriend = box.getAt(index);
      final updatefriend = Friend(
        id: friendID,
        title: newName,
        qrcode: oldfriend!.qrcode,
      );
      await box.putAt(index, updatefriend);
    }
    return box.values.toList();
  }
  @override
  Future<List<Friend>> deleteFriend(Friend friend) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = box.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      await box.deleteAt(index);
      return box.values.toList();
    }
    return [];
  }
  @override
  Future<List<Friend>> addQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = friends.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      friend.qrcode.add(qrcode);
      await box.putAt(index, friend);
    }
    return box.values.toList();
  }
  @override
  Future<List<Friend>> deleteQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = box.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      box.values.toList()[index].qrcode.removeWhere((q) => q.id == qrcode.id);
      await friends.putAt(index, box.values.toList()[index]);
      return box.values.toList();
    }
    return [];
  }
  @override
  Future<List<Friend>> editQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = box.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
       box.values.toList()[index].qrcode = box.values.toList()[index].qrcode.map((q) {
        return q.id == qrcode.id ? qrcode : q;
      }).toList();
      await friends.putAt(index, box.values.toList()[index]);
      return box.values.toList();
    }
    return [];
  }

}
