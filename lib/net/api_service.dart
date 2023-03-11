import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String BASE_URL = 'https://api.openai.com/v1';
  static const String API_KEY =
      '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';

  static Future<Map<String, dynamic>> createChatCompletion(
      List<Map<String, dynamic>> messages) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $API_KEY',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': messages,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create chat completion');
    }
  }
}
