import 'package:chat_app/constants/apiEndpoints.dart';
import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/services/apiService.dart';

class AuthRepository {
  final _api = ApiService();

  Future<UserModel> signUp(
    String first,
    String last,
    String email,
    String pass,
  ) async {
    final res = await _api.post(ApiEndpoints.signup, {
      "firstName": first,
      "lastName": last,
      "email": email,
      "password": pass,
    });
    return UserModel.fromJson(res['userObj']);
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final res = await _api.post(ApiEndpoints.login, {
      "email": email,
      "password": password,
      "keepMeSignedIn": true,
    });
    return res;
  }
}
