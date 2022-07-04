import 'dart:convert';

import 'package:http/http.dart' as http;

class crud {
  //للحصول على البيانات مثل select
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else
        print('error ${response.statusCode}');
    } catch (e) {
      print('error $e');
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else
        print('error ${response.statusCode}');
    } catch (e) {
      print('errorrrrrrrr $e');
    }
  }
}
