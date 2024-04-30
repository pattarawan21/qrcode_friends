import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode_fr/src/data/models/group/group_model.dart';
import 'package:qrcode_fr/src/data/models/friend/friend_model.dart';
import 'package:qrcode_fr/src/modules/groups/addgroup/addgroup_view_model.dart';

class AddGroupViewScreen extends ConsumerStatefulWidget {
  final GroupFriend? editName;
  final bool isEdit;

  const AddGroupViewScreen({super.key, this.editName, this.isEdit = false});

  @override
  ConsumerState<AddGroupViewScreen> createState() {
    return _AddGroupViewScreenState();
  }
}

class _AddGroupViewScreenState extends ConsumerState<AddGroupViewScreen> {
  final _titleController = TextEditingController();
  List<Friend> selectedFriends = [];
  late String groupId;


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
                  onPressed: () {
                    if (widget.editName == null) {
                      AddGroupViewModel.saveGroup(
                          ref: ref,
                          titleController: _titleController,
                          friendsToAdd: selectedFriends,
                          );
                      Navigator.of(context).pop();
                    } else {
                      AddGroupViewModel.editNameGroup(
                          ref: ref,
                          titleController: _titleController,
                          widget: widget);
                      Navigator.of(context).pop();
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
