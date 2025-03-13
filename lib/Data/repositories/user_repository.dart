import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';

class UserRepository {
  late String _username = "";
  late String _avatarPath = "assets/avatars/dog.jpg";
  final SharedPreferencesService shared;
  Function(String)? onUsernameChange;
  Function(String)? onAvatarChange;

  UserRepository(this.shared) {
    shared.fetchString("username").then(
      (val) {
        _username = val!;
        onUsernameChange?.call(_username);
      },
    );

    shared.fetchString("avatar_path").then((val) {
      if (val == null) {
        _avatarPath = "assets/avatars/dog.jpg";
      } else
        _avatarPath = val;

      onAvatarChange?.call(_avatarPath);
    });
  }

  String get username => _username;

  String get avatarPath => _avatarPath;

  Future<String> getUsername() async {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
    shared.saveString("username", _username);
  }

  void setAvatarPath(String path) {
    _avatarPath = path;
    shared.saveString("avatar_path", path);
    onAvatarChange?.call(_avatarPath);
  }
}
