import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:news_app/utils/helper.dart';

class Fetch {
  final http.Client client = http.Client();

  Map<String, String> get defaultHeaders {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<Map<String, dynamic>> get({
    String url = '',
  }) async {
    try {
      printData(
        'Url' + Uri.encodeFull('$url'),
      );
      http.Response response = await client.get(
        Uri.encodeFull('$url'),
        headers: defaultHeaders,
      );
      printData(
        'Response : ' + response.body,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> list = json.decode(response.body);

        return list;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }
}
