import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/index.dart' show Validator;

class BaseService {
  final String baseUrl;

  BaseService(this.baseUrl);

  Future getRequest(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    var response = await http.get(url, headers: headers);
    return Validator().handleResponse(response);
  }

  Future postRequest(String path,
      {Map<String, String>? headers, dynamic body}) async {
    var url = Uri.parse(baseUrl + path);
    var response = await http.post(url,
        headers: headers, body: body); //body: jsonEncode(body)
    return Validator().handleResponse(response);
  }

  // Future putRequest(String path,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   var url = Uri.parse(baseUrl + path);
  //   var response = await http.put(url,
  //       headers: headers, body: body); //body: jsonEncode(body)
  //   return Validator().handleResponse(response);
  // }

  // Future patchRequest(String path,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   var url = Uri.parse(baseUrl + path);
  //   var response = await http.patch(url,
  //       headers: headers, body: body); //body: jsonEncode(body)
  //   return Validator().handleResponse(response);
  // }

  // Future deleteRequest(String path, {Map<String, String>? headers}) async {
  //   var url = Uri.parse(baseUrl + path);
  //   var response = await http.delete(url, headers: headers);
  //   return Validator().handleResponse(response);
  // }
}
