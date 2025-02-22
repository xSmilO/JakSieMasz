class UserRepository {
  String _username = "Cygix";

  UserRepository();

  String get username {
    return _username;
  }

  Future<String> getUsername() async {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
  }
}
