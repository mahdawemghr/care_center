import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Care Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Text(
            'Welcome to the Care Center Home Page!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
