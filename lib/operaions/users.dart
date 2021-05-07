import 'dart:convert';

import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/countries.dart';
import 'package:http/http.dart' as http;

class User {
  String id,
      roleId,
      name,
      email,
      userName,
      phone,
      avatar,
      createdAt,
      updatedAt,
      countryId,
      gender,
      currentLocationId,
      cityId,
      fcmToken,
      apiToken,
      errorMessage;
  Country country;
  ApiUrl api = new ApiUrl();
  Future<User> login(String userName, String password) async {
    User user = new User();
    try {
      http.Response response = await http.post(Uri.parse(api.getUrl("login")),
          body: {'user_name': userName, 'password': password});
      var result = jsonDecode(response.body);
      print(result);
      if (result['data'] != null) {
        user.id = result['data']['id'];
        user.name = result['data']['name'];
        user.roleId = result['data']['role_id'];
        user.userName = result['data']['user_name'];
        user.email = result['data']['email'];
        user.phone = result['data']['phone'];
        user.avatar = api.storageUrl + "/" + result['data']['avatar'];
        user.createdAt = result['data']['created_at'];
        user.updatedAt = result['data']['updated_at'];
        user.countryId = result['data']['country_id'];
        user.gender = result['data']['gender'];
        user.currentLocationId = result['data']['current_location_id'];
        user.cityId = result['data']['city_id'];
        user.fcmToken = result['data']['fcm_token'];
        user.apiToken = result['data']['api_token'];
        Country cn = new Country();
        cn.id = result['data']['country']['id'];
        cn.name = result['data']['country']['name'];
        cn.nameAr = result['data']['country']['name_ar'];
        cn.currency = result['data']['country']['currency'];
        cn.currencyAr = result['data']['country']['currency_ar'];
        cn.code = result['data']['country']['cod'];
        cn.slug = result['data']['country']['slug'];
        user.country = cn;
        return user;
      } else {
        user.errorMessage = result['message'];
      }
      return user;
    } catch (e) {
      print(e);
      return user;
    }
  }
}
