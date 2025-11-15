import 'package:chat_app/models/chatmsg.dart';
import 'package:chat_app/services/chatService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatProvider = StateNotifierProvider<ChatController, List<ChatModel>>((
  ref,
) {
  return ChatController(ref.watch(chatRepositoryProvider));
});

class ChatController extends StateNotifier<List<ChatModel>> {
  final ChatRepository _repo;
  ChatController(this._repo) : super([]);

  Future<void> sendMessage(String text) async {
    state = [...state, ChatModel(text: text, isUser: true)];
    try {
      final reply = await _repo.sendMessage(text);
      state = [...state, ChatModel(text: reply, isUser: false)];
    } catch (e) {
      state = [...state, ChatModel(text: "Error: $e", isUser: false)];
    }
  }
}
