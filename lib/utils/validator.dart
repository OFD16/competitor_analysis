import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

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

  handleResponse(dynamic response) {
    var responseBody = response.body;
    var statusCode = response.statusCode;

    if (statusCode == 200) {
      // print('responsebody: $responseBody');
      var element = parse(responseBody);
      // print('element: $element');
      return element;
    } else {
      throw Exception('Request failed. Status code: $statusCode');
    }
  }
}
