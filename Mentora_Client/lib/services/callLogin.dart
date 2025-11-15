import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginUser({
  required String email,
  required String password,
  required bool keepMeSignedIn,
}) async {
  const url = "http://10.0.2.2:8080/login";  // Replace this

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "keepMeSignedIn": keepMeSignedIn,
    }),
  );

  // If status code is not 200 → your backend rejected it
  if (response.statusCode != 200) {
    throw Exception("Server responded with status ${response.statusCode}");
  }

  return jsonDecode(response.body);
}
