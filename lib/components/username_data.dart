import 'dart:convert';
import 'dart:io';

class UsernameData {
  // reads users from json file
  Future<List<Map<String, dynamic>>> readUsers() async {
    final file = File('assets/data/users.json');

    if (!await file.exists()) {
      return [];
    }

    try {
      final contents = await file.readAsString();
      final List<dynamic> jsonData = contents.isNotEmpty
          ? jsonDecode(contents)
          : [];
      return List<Map<String, dynamic>>.from(jsonData);
    } catch (e) {
      print('Error reading users: $e');
      return [];
    }
  }

  // checks if user exists in json data
  bool userExists(List<Map<String, dynamic>> users, String username) {
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
  bool validateUser(
    List<Map<String, dynamic>> users,
    String username,
    String password,
  ) {
    return users.any(
      (user) => user['username'] == username && user['password'] == password,
    );
  }
}
