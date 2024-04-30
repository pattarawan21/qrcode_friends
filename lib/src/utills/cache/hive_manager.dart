import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';


class HiveManager{
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FriendAdapter());
    Hive.registerAdapter(QrCodeAdapter());
    Hive.registerAdapter(GroupFriendAdapter());
    await Hive.openBox<Friend>('friend');
    await Hive.openBox<QrCode>('qrcode');
    await Hive.openBox<GroupFriend>('groupfriend');

  }
}