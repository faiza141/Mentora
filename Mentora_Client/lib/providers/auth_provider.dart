import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
      return AuthController(ref.watch(authRepositoryProvider));
    });

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repo;
  AuthController(this._repo) : super(const AsyncValue.data(null));

  Future<void> signUp(String f, String l, String e, String p) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repo.signUp(f, l, e, p);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repo.signIn(email, password);
      final user = UserModel.fromJson(data['data']);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
