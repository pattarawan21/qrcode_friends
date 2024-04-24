import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';  

part 'friends.g.dart';

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

@HiveType(typeId: 3)
class GroupFriend {
  GroupFriend({
    required this.title,
    String? id,
    List<Friend>? listfriend
  }) : id = id ?? uuid.v4(),
    listfriend = listfriend ?? [];
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  List<Friend> listfriend;
}