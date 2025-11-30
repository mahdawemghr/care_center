import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UsernameData {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Reads users from Firestore collection 'userData'
  Future<List<Map<String, dynamic>>> readUsers() async {
    final usernameData = await db.collection('userData').get();
    return usernameData.docs.map((doc) => doc.data()).toList();
  }

  // Checks if user exists
  Future<bool> userExists(String username) async {
    final users = await readUsers();
    return users.any((user) => user['username'] == username);
  }

  // Adds a new user
  Future<void> addUser(String username, String password) async {
    await db.collection('userData').add({
      'username': username,
      'password': password,
    });
  }

  // Validates username and password
  Future<bool> validateUser(String username, String password) async {
    final users = await readUsers();
    final user = users.firstWhere(
      (user) => user['username'] == username,
      orElse: () => {},
    );
    if (user.isNotEmpty) {
      return user['password'] == password;
    }
    return false;
  }
}
