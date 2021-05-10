import 'dart:convert';

import 'package:easy/data/models/categoryModel.dart';

import 'apiUrls.dart';
import 'package:http/http.dart' as http;

class Country {
  ApiUrl api = new ApiUrl();
  String id, name, nameAr, currency, currencyAr, code, slug, image;
  Future<List> getCountries() async {
    List<Country> data = [];
    try {
      http.Response response =
          await http.get(Uri.parse(api.getUrl("getCountries")));
      var result = jsonDecode(response.body);
      //print(result['data']);
      if (result['data'] != null) {
        List cns = result['data'];
        Country country;
        for (var item in cns) {
          country = new Country();
          //print(item['id']);
          country.id = item['id'].toString();
          country.name = item['name'];
          country.nameAr = item['name_ar'];
          country.code = item['cod'];
          country.slug = item['slug'];
          country.image = api.storageUrl + item['image'];
          data.add(country);
        }
      }
      //print(data.toString());
      return data;
    } catch (e) {
      print(e);
      return data;
    }
  }

  Future<List<CatModel>> getCountryCates(String name) async {
    List<CatModel> data = [];
    try {
      http.Response response =
          await http.get(Uri.parse(api.getCountryCateUrl(name)));
      var result = jsonDecode(response.body);
      if (result['data']['categories'] != null) {
        var cates = result['data']['categories'];
        for (var cate in cates) {
          //print(cate);
          data.add(CatModel(null, api.storageUrl + cate['image'], cate['name'],
              cate['slug']));
        }
      }
      //print(data);
      return data;
    } catch (e) {
      print(e);
      return data;
    }
  }
}
