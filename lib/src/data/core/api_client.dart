import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({
    required this.client,
  });

  Future<Map<String, dynamic>> get(String path) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
