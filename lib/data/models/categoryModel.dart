class CatModel {
  int id;
  String photoUrl;
  String lable;

  CatModel(this.id, this.photoUrl, this.lable);
  CatModel.fromjson(parsedJSON) {
    this.id = parsedJSON['id'];
    this.photoUrl = parsedJSON['photo'];
    this.lable = parsedJSON['lable'];
  }
}
