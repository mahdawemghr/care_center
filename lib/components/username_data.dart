import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class UsernameData {
  // reads users from json file
  Future<List<Map<String, dynamic>>> readUsers() async {
    try {
      final contents = await rootBundle.loadString('assets/data/users.json');
      final List<dynamic> jsonData = jsonDecode(contents);
      return List<Map<String, dynamic>>.from(jsonData);
    } catch (e) {
      print('Error reading users: $e');
      return [];
    }
  }

  // checks if user exists in json data
  Future<bool> userExists(String username) async {
    final users = await readUsers();
    return users.any((user) => user['username'] == username);
  }

  // if user registered, this function adds the new user to the list
  Future<void> addUser(String username, String password) async {
    final users = await readUsers();
    users.add({'username': username, 'password': password});

    final file = File('assets/data/users.json');
    try {
      final jsonString = jsonEncode(users);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error writing users: $e');
    }
  }

  // this function to chack the password for a given username
  Future<bool> validateUser(String username, String password) async {
    final users = await readUsers();
    return users.any(
      (user) => user['username'] == username && user['password'] == password,
    );
  }
}
