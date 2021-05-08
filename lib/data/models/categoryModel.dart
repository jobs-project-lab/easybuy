class CatModel {
  int id;
  String photoUrl;
  String lable;
  String slug;
  CatModel(this.id, this.photoUrl, this.lable, this.slug);
  CatModel.fromjson(parsedJSON) {
    this.id = parsedJSON['id'];
    this.photoUrl = parsedJSON['photo'];
    this.lable = parsedJSON['lable'];
  }
}
