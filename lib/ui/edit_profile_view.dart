import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;

  EditProfileScreen({required this.currentName});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  bool _saving = false;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    setState(() {
      _saving = true;
    });

    // TODO: Implement logic to save name to server or local storage.

    setState(() {
      _saving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Name saved successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Pass back the updated name to the previous screen.
    Navigator.pop(context, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saving ? null : _saveName,
              child: _saving ? CircularProgressIndicator() : Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
