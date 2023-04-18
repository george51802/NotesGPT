import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;

  EditProfileScreen({required this.currentName});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with TickerProviderStateMixin {
  late TextEditingController _nameController;
  bool _saving = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);

    // Initialize the animation controller and fade animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animationController.dispose();
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

    _animationController.forward(); // Start fade animation

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
              child: _saving
                  ? CircularProgressIndicator()
                  : Text('Save'),
            ),
          ],
        ),
      ),
      // Add fade animation for showing snackbar
      floatingActionButton: FadeTransition(
        opacity: _fadeAnimation,
        child: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Name saved successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
