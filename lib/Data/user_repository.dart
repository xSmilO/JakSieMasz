import 'package:jak_sie_masz/Data/shared_preferences_service.dart';

class UserRepository {
  late String _username = "";
  final SharedPreferencesService shared;
  Function(String)? onUsernameChange;

  UserRepository(this.shared) {
    shared.fetchString("username").then(
      (val) {
        _username = val!;
        onUsernameChange?.call(_username);
      },
    );
  }

  String get username {
    return _username;
  }

  Future<String> getUsername() async {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
    shared.saveString("username", _username);
  }
}
