import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_fr/models/friends.dart';

class FriendNotifier extends StateNotifier<List<Friend>> {
  FriendNotifier() : super([]) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = Hive.box<Friend>('Friend').values.toList();
  }

  final Box<Friend> friends = Hive.box<Friend>('friend');

  void addFriend(String name) async {
    final box = await Hive.openBox<Friend>('friend');
    final friend = Friend(title: name);
    box.add(friend);
    state = [...state, friend];
  }

  void editFriend(String friendID, String newName) async {
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
    state = box.values.toList();
  }

  Future deleteFriend(Friend friend) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = state.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      await box.deleteAt(index);
      state = box.values.toList();
    }
  }

  void addQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = friends.values.toList().indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      friend.qrcode.add(qrcode);
      await box.putAt(index, friend);
    }
    state = box.values.toList();
  }

  void deleteQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = state.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      state[index].qrcode.removeWhere((q) => q.id == qrcode.id);
      await friends.putAt(index, state[index]);
      state = box.values.toList();
    }
  }

  void editQrcode(Friend friend, QrCode qrcode) async {
    final box = await Hive.openBox<Friend>('friend');
    final index = state.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      state[index].qrcode = state[index].qrcode.map((q) {
        return q.id == qrcode.id ? qrcode : q;
      }).toList();
      await friends.putAt(index, state[index]);
      state = box.values.toList();
    }
  }
}

final FriendProvider =
    StateNotifierProvider<FriendNotifier, List<Friend>>(
        (ref) => FriendNotifier());
