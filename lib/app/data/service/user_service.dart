import '../provider/users_api.dart';

class UserService {
  
  final _api = UsersApi();
  Future<int> createUser(email, username, password) async {
    return _api.createUser(
        email: email, username: username, password: password);
  }
  
}
