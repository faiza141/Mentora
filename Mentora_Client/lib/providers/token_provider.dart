import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/services/token_service.dart';

class TokenState {
  final String? accessToken;
  final String? refreshToken;

  const TokenState({this.accessToken, this.refreshToken});
}

class TokenNotifier extends StateNotifier<TokenState> {
  TokenNotifier() : super(const TokenState());

  Future<void> loadTokens() async {
    final access = await TokenService.getAccessToken();
    final refresh = await TokenService.getRefreshToken();

    state = TokenState(
      accessToken: access,
      refreshToken: refresh,
    );
  }

  Future<void> setTokens({
    required String access,
    required String refresh,
  }) async {
    await TokenService.saveTokens(
      accessToken: access,
      refreshToken: refresh,
    );

    state = TokenState(
      accessToken: access,
      refreshToken: refresh,
    );
    print("store state updated.\n$state");
  }

  Future<void> clear() async {
    await TokenService.clearTokens();
    state = const TokenState();
  }
}

final tokenProvider =
StateNotifierProvider<TokenNotifier, TokenState>((ref) {
  return TokenNotifier();
});
