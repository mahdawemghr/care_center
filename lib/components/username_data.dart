class UsernameData {
  final String username;
  final String password;

  UsernameData({required this.username, required this.password});

  factory UsernameData.fromJson(Map<String, dynamic> json) {
    return UsernameData(username: json['username'], password: json['password']);
  }

  // checks if user exists in json data
  // static bool userExists(String username) {
  //   for (var user in users) {
  //     if (user.username == username) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // if user registered, this function adds the new user to the list
  static void addUser(
    List<UsernameData> users,
    String username,
    String password,
  ) {
    users.add(UsernameData(username: username, password: password));
  }

  // this function to chack the password for a given username
  static bool checkPassword(
    List<UsernameData> users,
    String username,
    String password,
  ) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }
}
