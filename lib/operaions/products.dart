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

  Future<List> getFeaturedSlider(String countrySlug, String cateId) async {
    try {
      http.Response response =
          await http.get(Uri.parse(api.getCountryCateUrl(countrySlug)));
      var result = jsonDecode(response.body);
      //print(result['data']['advertise']);
      List data = [];
      var fts = result['data']['advertise']['ad_slider'];

      if (fts != null) {
        for (var item in fts) {
          if (item['category_id'].toString() == cateId) data.add(item);
        }
      }
      //print(data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List> getSubCategories(String countryName, String category) async {
    try {
      String url = api.getSubCateLink(countryName.toLowerCase(), category);
      //print(url);
      http.Response response = await http.get(Uri.parse(url));
      var result = jsonDecode(response.body);
      //print(result);
      if (result['data']['categories'] != null) {
        List data = [];
        var cates = result['data']['categories'];
        for (var cate in cates) {
          data.add(cate);
        }
        return data;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
