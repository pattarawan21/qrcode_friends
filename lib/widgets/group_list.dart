import 'package:flutter/material.dart';
import 'package:qrcode_fr/models/friends.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/providers/group_provider.dart';
import 'package:qrcode_fr/screens/add_group.dart';
import 'package:qrcode_fr/widgets/friend_list.dart';


class GroupList extends ConsumerStatefulWidget {
  const GroupList(this.group, {super.key});

  @override
  ConsumerState<GroupList> createState() => _GroupListState();

  final List<GroupFriend> group;
}

class _GroupListState extends ConsumerState<GroupList> {
  @override
  Widget build(BuildContext context) {
    if (widget.group.isEmpty) {
      return Center(
        child: Text(
          'No group added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.group.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          widget.group[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        subtitle: Text(
          widget.group[index].listfriend.length.toString(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddGroupScreen(
                        editName: widget.group[index],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await ref
                        .read(groupFriendProvider.notifier)
                        .deleteFriend(widget.group[index]);
                  }),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => FriendList(
                friends: widget.group[index].listfriend,
            ),
            ),
          );
        },
      ),
    );
  }
}
