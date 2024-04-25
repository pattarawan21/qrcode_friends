import 'package:qrcode_fr/models/friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/providers/friend_provider.dart';
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
  List<Friend> selectedFriends = [];
  late String groupId;


  void _saveGroup() async{
    final enteredText = _titleController.text;
    if (!enteredText.isEmpty) {
      groupId = await ref.read(groupFriendProvider.notifier).addGroupFriend(enteredText);
      selectedFriends.forEach((friend) {
      ref.read(groupFriendProvider.notifier).addFriendToGroup(groupId,selectedFriends);
  });
      Navigator.of(context).pop();
    }
  }
 
//   void _addGroupFriends() {
//     if (groupId == null) {
//     // Show an error message or handle the situation
//     print('Error: Group ID is not initialized.');
//     return;
//   }

//   selectedFriends.forEach((friend) {
//     ref.read(groupFriendProvider.notifier).addFriendToGroup(groupId,selectedFriends);
//   });
//   // Navigate back or show a success message
// }

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
    final allFriends = ref.watch(friendProvider);
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
            widget.editName != null
                ? const SizedBox()
                :
            ListView.builder(
              shrinkWrap: true,
              itemCount: allFriends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allFriends[index].title),
                  trailing: Checkbox(
                    value: selectedFriends.contains(allFriends[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedFriends.add(allFriends[index]);
                        } else {
                          selectedFriends.remove(allFriends[index]);
                        }
                      });
                    },
                  ),
                );
              },
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
