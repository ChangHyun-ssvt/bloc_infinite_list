import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiHelper {
  final String url;

  ApiHelper({this.url});

  Future getData() async {
    try {
      http.Response response = await http.get(this.url);
      if (response.statusCode != 200)
        throw HttpException('${response.statusCode}');
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } catch (e) {
      throw e;
    }
  }
}
