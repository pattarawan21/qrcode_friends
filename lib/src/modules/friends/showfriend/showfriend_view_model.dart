import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/common/constants/icon_constant.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/friends/addfriend/addfriend_view.dart';
import 'package:qrcode_fr/src/modules/qrcodes/showqrcode/showqrcodelist_view.dart';


class ShowFriendViewModel extends ConsumerStatefulWidget {
  const ShowFriendViewModel ({super.key, required this.friends});

  @override
  ConsumerState<ShowFriendViewModel> createState() => _ShowFriendViewModelState();

  final List<Friend> friends;
}

class _ShowFriendViewModelState extends ConsumerState<ShowFriendViewModel > {
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
        subtitle: Text(
          widget.friends[index].qrcode.length.toString() + ' Qr Codes',
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
                icon: IconConstant().iconEdit,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddFriendViewScreen(
                        editName: widget.friends[index],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                  icon: IconConstant().iconDelete,
                  onPressed:()  {
                     ref
                        .read(friendProvider.notifier)
                        .tryDeleteFriend(widget.friends[index]);
                  }
                  ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ShowQrcodeListView(
                friend: widget.friends[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
