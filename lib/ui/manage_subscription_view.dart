import 'package:flutter/material.dart';

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({Key? key}) : super(key: key);

  @override
  _ManageSubscriptionScreenState createState() => _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  bool _isVisible = true; // Track visibility of the widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        title: Text('Manage Subscription'),
      ),
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Unsubscribe'),
              onTap: () {},
            ),
          ),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: ListTile(
              leading: Icon(Icons.upgrade),
              title: Text('Upgrade Subscription'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
