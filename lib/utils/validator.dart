import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Regular expression pattern to validate email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  Future<String?> validateURL(String? value) async {
    if (value == null || value.isEmpty) {
      print('ASdfg');
      return 'URL is required.';
    }

    if (!await canLaunchUrl(Uri.parse(value))) {
      return 'Invalid URL format.';
    }

    return null;
  }

  Response handleResponse(Response response) {
    var responseBody = response.body;
    var statusCode = response.statusCode;

    if (statusCode == 200) {
      // print('responsebody: $responseBody');
      //var element = parse(responseBody);
      // print('element: $element');
      return response;
    } else {
      throw Exception('Request failed. Status code: $statusCode');
    }
  }
}
