import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/data/services/friend/friend_service.dart';
import 'dart:typed_data';


class MockFriendService extends Mock implements FriendService {}

void main(){
  late FriendService sut;
  

  setUp(() {
    sut = MockFriendService();
  });
  group('Friend Service', () {

    final mockFriend = [
    Friend(id : '1',title: 'Jack', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]),
    Friend(id : '2',title: 'Jane', qrcode: [QrCode(title: '2', imagebytes: Uint8List.fromList([255]))]),
    Friend(id : '3',title: 'John', qrcode: [QrCode(title: '3', imagebytes: Uint8List.fromList([255]))]),
    Friend(id : '4',title: 'Job'),
    ];
    test(
    'should add a friend and return a list of friends',
    () async {
      final updateFriend = List<Friend>.from(mockFriend);
      updateFriend.add(Friend(title: 'Jill'));
      when(() => sut.addFriend('Jill')).thenAnswer((_) async => updateFriend);
      final result = await sut.addFriend('Jill');
      expect(result, updateFriend);
      verify(() => sut.addFriend('Jill')).called(1);
    }
    );
    test(
    'should load a list of friends',
    () async {
      when(() => sut.loadUser()).thenAnswer((_) async => mockFriend);
      final result = await sut.loadUser();
      expect(result, isA<List<Friend>>());
      verify(() => sut.loadUser()).called(1);
    }
    );
    test(
    'should delete a friend and return a list of friends',
     () async {
    final listFriend = List<Friend>.from(mockFriend);
    final friendToDelete = Friend(id: '1', title: 'Jack', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]);
    listFriend.removeWhere((friend) => friend.id == friendToDelete.id);
    when(() => sut.deleteFriend(friendToDelete)).thenAnswer((_) async => listFriend);
    final result = await sut.deleteFriend(friendToDelete);
    expect(result, listFriend);
    verify(() => sut.deleteFriend(friendToDelete)).called(1);
    // Check that the friend with the specified id has been removed from listFriend
    expect(listFriend.where((friend) => friend.id == friendToDelete.id), isEmpty);
  },
    );
    test(
    'should edit a friend and return a list of friends ',
    () async {
      final listFriend = List<Friend>.from(mockFriend);
      listFriend[0] = Friend(title: 'Jackie', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]);
      when(() => sut.editFriend('Jack', 'Jackie')).thenAnswer((_) async => listFriend);
      final result = await sut.editFriend('Jack', 'Jackie');
      expect(result, anyElement((friend) => friend.title == 'Jackie'));
      verify(() => sut.editFriend('Jack', 'Jackie')).called(1);
    }
    );
    test(
    'should add a qrcode from a friend and return a list of friends',
     () async {
      final listfriend = List<Friend>.from(mockFriend);
      final friendToaddQr= Friend(title: 'Jack',id:'1', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]);
      final qrtoadd = QrCode(title: '4', imagebytes: Uint8List.fromList([255]));
      when(() => sut.addQrcode(friendToaddQr, qrtoadd)
      ).thenAnswer((_) async {
        final index = listfriend.indexWhere((e) => e.id == friendToaddQr.id);
        if (index >= 0) {
          friendToaddQr.qrcode.add(qrtoadd);
          listfriend[index] = friendToaddQr;
        }
        return listfriend;
      });
      final result = await sut.addQrcode(friendToaddQr, qrtoadd);
      expect(result, listfriend);
      verify(() => sut.addQrcode(friendToaddQr, qrtoadd)).called(1);
     }
      );
    test(
    'should delete a qrcode from a friend and return a list of friends',
    () async {
      final listfriend = List<Friend>.from(mockFriend);
      final friendTodeleteQr= Friend(title: 'Jack',id:'1', qrcode: [QrCode(title: '1', imagebytes: Uint8List.fromList([255]))]);
      final qrtodelete = QrCode(title: '1', imagebytes: Uint8List.fromList([255]));
      when(() => sut.deleteQrcode(friendTodeleteQr, qrtodelete)
      ).thenAnswer((_) async {
        final index = listfriend.indexWhere((e) => e.id == friendTodeleteQr.id);
        if (index >= 0) {
          friendTodeleteQr.qrcode.removeWhere((q) => q.id == qrtodelete.id);
          listfriend[index] = friendTodeleteQr;
        }
        return listfriend;
      });
      final result = await sut.deleteQrcode(friendTodeleteQr, qrtodelete);
      expect(result, listfriend);
      verify(() => sut.deleteQrcode(friendTodeleteQr, qrtodelete)).called(1);
    }
    );
    test(
    'should edit a qrcode from a friend and return a list of friends',
    () async {
      final listfriend = List<Friend>.from(mockFriend);
      final friendToeditQr= Friend(title: 'Jack',id:'1', qrcode: [QrCode(title: '1',id:'1', imagebytes: Uint8List.fromList([255]))]);
      final qrtoedit = QrCode(title: 'test', id : '1',imagebytes: Uint8List.fromList([255]));
      when(() => sut.editQrcode(friendToeditQr, qrtoedit)
      ).thenAnswer((_) async {
        final index = listfriend.indexWhere((e) => e.id == friendToeditQr.id);
        if (index >= 0) {
          friendToeditQr.qrcode = friendToeditQr.qrcode.map((q) {
            return q.id == qrtoedit.id ? qrtoedit : q;
          }).toList();
          listfriend[index] = friendToeditQr;
        }
        return listfriend;
      });
      final result = await sut.editQrcode(friendToeditQr, qrtoedit);
      expect(result, listfriend);
      verify(() => sut.editQrcode(friendToeditQr, qrtoedit)).called(1);
    }
    );
   });

}

