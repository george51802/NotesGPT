import 'package:flutter/material.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Subscription'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Manage Subscription'),
          onPressed: () {
            // Add code here to manage subscription
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, 
    );
  }
}
