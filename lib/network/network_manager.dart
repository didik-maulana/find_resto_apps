import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  final String _apiKey = 'f2d6a85e4d0c8f0bc99dd4f61a5498ed';
  final String _hostUrl = 'developers.zomato.com';
  final String _apiVersion = 'api/v2.1';

  Future<Map<String, dynamic>> request({
    @required String path,
    Map<String, String> parameters,
  }) async {
    final uri = Uri.https(_hostUrl, '$_apiVersion/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);

    return jsonObject;
  }

  Map<String, String> get _headers {
    return {
      'Accept': 'application/json',
      'user-key': _apiKey,
    };
  }
}
