// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupFriendAdapter extends TypeAdapter<GroupFriend> {
  @override
  final int typeId = 3;

  @override
  GroupFriend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupFriend(
      title: fields[1] as String,
      id: fields[0] as String?,
      listfriend: (fields[2] as List?)?.cast<Friend>(),
    );
  }

  @override
  void write(BinaryWriter writer, GroupFriend obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.listfriend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupFriendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
