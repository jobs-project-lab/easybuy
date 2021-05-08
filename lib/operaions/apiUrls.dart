class ApiUrl {
  String apiUrl = "http://easybuy-in.com/new/public/api";
  String storageUrl = "https://easybuy-in.com/new/storage/";
  String getUrl(String type) {
    switch (type) {
      case "login":
        return apiUrl + "/login";
      case "getCountries":
        return apiUrl + "/countries";
      default:
        return apiUrl;
    }
  }

  String getCountryCateUrl(String name) {
    return apiUrl + "/" + name + "/categories";
  }

  String getSubCateLink(String countryName, String cateName) {
    return apiUrl + "/" + countryName + "/" + cateName + "/subcategory";
  }
}
