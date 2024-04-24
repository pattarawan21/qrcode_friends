import 'package:qrcode_fr/models/friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/providers/group_provider.dart';

class AddGroupScreen extends ConsumerStatefulWidget {
  final GroupFriend? editName;
  final bool isEdit;

  const AddGroupScreen({super.key, this.editName, this.isEdit = false});

  @override
  ConsumerState<AddGroupScreen> createState() {
    return _AddGroupScreenState();
  }
}

class _AddGroupScreenState extends ConsumerState<AddGroupScreen> {
  final _titleController = TextEditingController();

  void _saveGroup() {
    final enteredText = _titleController.text;
    if (!enteredText.isEmpty) {
      ref.read(groupFriendProvider.notifier).addGroupFriend(enteredText);
      Navigator.of(context).pop();
    }
  }

  void _editNameGroup() {
    final enteredText = _titleController.text;
    if (!enteredText.isEmpty) {
      ref
          .read(groupFriendProvider.notifier)
          .editGroupFriend(widget.editName!.id.toString(), enteredText);
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
              : "Add Group",
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
                      widget.editName == null ? _saveGroup : _editNameGroup,
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
