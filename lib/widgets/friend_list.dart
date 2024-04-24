import 'package:flutter/material.dart';
import 'package:qrcode_fr/models/friends.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/widgets/qr_list.dart';

class FriendList extends ConsumerStatefulWidget {
  const FriendList(this.friends, {super.key});

  @override
  ConsumerState<FriendList> createState() => _FriendListState();

  final List<Friend> friends;
}

class _FriendListState extends ConsumerState<FriendList> {
  @override
  Widget build(BuildContext context) {
    if (widget.friends.isEmpty) {
      return Center(
        child: Text(
          'No Friend added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.friends.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          widget.friends[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => QrList(friend:widget.friends[index],),
            ),
          );
        },
      ),
    );
  }
}
