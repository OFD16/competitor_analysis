import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  Future<dynamic> getUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get user: ${response.statusCode}');
    }
  }

  Future<dynamic> updateUser(
      String userId, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      body: userData,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }
}
