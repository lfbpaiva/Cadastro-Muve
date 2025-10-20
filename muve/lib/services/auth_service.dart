import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Vai funcionar via USB com adb reverse
  static const String _baseUrl = 'http://127.0.0.1:3000';

  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final uri = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {
        'success': false,
        'message': 'Erro ${response.statusCode}: ${response.reasonPhrase}',
      };
    }
  }

  static Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final uri = Uri.parse('$_baseUrl/auth/register');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {
        'success': false,
        'message': 'Erro ${response.statusCode}: ${response.reasonPhrase}',
      };
    }
  }
}

