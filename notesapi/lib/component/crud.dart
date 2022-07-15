import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

  postRequestWithfile(File file, Map data, String url) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());

    var multiPartfile = http.MultipartFile("notes_image", stream, lenght,
        filename: basename(file.path));

        request.files.add(multiPartfile);

        data.forEach((key, value) { 
          request.fields[key]=value;
        });

        var myrequest=await request.send();
        
        var response=await http.Response.fromStream(myrequest);
        if(myrequest.statusCode==200){
          print(response.body);
          return jsonDecode(response.body);
        }
        else
        {
          print('error ${myrequest.statusCode}');
        }
  }
}
