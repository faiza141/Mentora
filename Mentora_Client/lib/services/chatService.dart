import 'package:chat_app/constants/apiEndpoints.dart';
import 'package:chat_app/services/apiService.dart';

class ChatRepository {
  final _api = ApiService();

  Future<String> sendMessage(String query) async {
    final res = await _api.get("${ApiEndpoints.chat}?query=$query");
    return res['response'] ?? "No response";
  }
}
