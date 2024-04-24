import 'package:qrcode_fr/models/friends.dart';
import 'package:qrcode_fr/providers/friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFriendScreen extends ConsumerStatefulWidget {
  final Friend? editName;
  final bool isEdit;

  const AddFriendScreen({super.key, this.editName, this.isEdit = false});

  @override
  ConsumerState<AddFriendScreen> createState() {
    return _AddFriendScreenState();
  }
}

class _AddFriendScreenState extends ConsumerState<AddFriendScreen> {
  final _titleController = TextEditingController();

  void _saveFriend() {
    final enteredText = _titleController.text;
    if (!enteredText.isEmpty) {
      ref.read(friendProvider.notifier).addFriend(enteredText);
      Navigator.of(context).pop();
    }
  }

  void _editNameFriend() {
    final enteredText = _titleController.text;
    if (!enteredText.isEmpty) {
      ref
          .read(friendProvider.notifier)
          .editFriend(widget.editName!.id.toString(), enteredText);
      Navigator.of(context).pop();
    }
  }

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
                  onPressed:
                      widget.editName == null ? _saveFriend : _editNameFriend,
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