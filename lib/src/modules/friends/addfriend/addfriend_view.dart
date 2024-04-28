import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/friends/addfriend/addfriend_view_model.dart';

class AddFriendViewScreen extends ConsumerStatefulWidget {
  final Friend? editName;
  final bool isEdit;

  const AddFriendViewScreen({super.key, this.editName, this.isEdit = false});

  @override
  ConsumerState<AddFriendViewScreen> createState() {
    return _AddFriendViewScreenState();
  }
}

class _AddFriendViewScreenState extends ConsumerState<AddFriendViewScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editName != null
              ? "Edit Name : ${widget.editName?.title}"
              : "Add Friend",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.editName == null) {
                      AddFriendViewModel.saveFriend(
                          context: context,
                          ref: ref,
                          titleController: _titleController);
                    } else {
                      AddFriendViewModel.editNameFriend(
                          context: context,
                          ref: ref,
                          titleController: _titleController,
                          widget: widget);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
