import 'package:flutter/material.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        title: Text('Manage Subscription'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.cancel),
            title: Text('Unsubscribe'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.upgrade),
            title: Text('Upgrade Subscription'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
