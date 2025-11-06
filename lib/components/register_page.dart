import 'package:flutter/material.dart';

MaterialPageRoute<dynamic> registerPage() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('Registration Page')),
    ),
  );
}
