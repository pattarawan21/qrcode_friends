import 'package:qrcode_fr/providers/friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFriendScreen extends ConsumerStatefulWidget {
  const AddFriendScreen({super.key});

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
      ref.read(FriendProvider.notifier).addFriend(enteredText);
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
        title: const Text('Add Friend'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveFriend,
              icon: const Icon(Icons.add),
              label: const Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}