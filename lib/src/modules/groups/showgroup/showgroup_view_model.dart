import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/modules/groups/addgroup/addgroup_view.dart';
import 'package:qrcode_fr/src/modules/groups/showgroup/showfriendingroup_view.dart';



class ShowGroupFriendViewModel extends ConsumerStatefulWidget {
  const ShowGroupFriendViewModel(this.group, {super.key});

  @override
  ConsumerState<ShowGroupFriendViewModel> createState() => _ShowGroupFriendViewModelState();

  final List<GroupFriend> group;
}

class _ShowGroupFriendViewModelState extends ConsumerState<ShowGroupFriendViewModel> {
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
                      builder: (ctx) => AddGroupViewScreen(
                        editName: widget.group[index],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                     ref
                        .read(groupFriendProvider.notifier)
                        .tryDeleteGroupFriend(widget.group[index]);
                  }),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  ShowFriendinGroupScreen(id: widget.group[index].id),
            ),
          );
        },
      ),
    );
  }
}
