import 'package:http/http.dart' as http;

class ChatModel {
  final String text;
  final bool isUser;
  //DateTime timestamp;

  ChatModel({
    required this.text,
    required this.isUser,
    //this.timestamp,
  });
}
