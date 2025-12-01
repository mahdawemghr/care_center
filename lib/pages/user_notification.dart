import 'package:flutter/material.dart';

class UserNotification extends StatelessWidget {
  const UserNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(color: Color(Colors.white.value)),
      ),
      body: const Center(child: Text('No new notifications')),
    );
  }
}
