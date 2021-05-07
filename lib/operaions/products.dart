import 'dart:convert';

import 'package:http/http.dart' as http;
import 'apiUrls.dart';

class Product {
  ApiUrl api = new ApiUrl();

  Future<List> getFeatured(String countryName) async {
    try {
      http.Response response =
          await http.get(Uri.parse(api.getCountryCateUrl(countryName)));
      var result = jsonDecode(response.body);
      //print(result['data']['advertise']);
      List data = [];
      var fts = result['data']['advertise'];
      if (fts != null) {
        for (var item in fts) {
          item['image'] = api.storageUrl + item['image'];
          //print(item);
          data.add(item);
        }
      }
      //print(data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
