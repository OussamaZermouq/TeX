import '../provider/users_api.dart';

class UserService {
  final _api = UsersApi();
  Future<int> createUser(userId,email, username, password) async {
    return _api.createUser(
        userId:userId,email: email, username: username, password: password);
  }
}
