import 'dart:convert';
import 'dart:io';

import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAds extends StatefulWidget {
  final id;

  const UpdateAds({Key key, this.id}) : super(key: key);
  @override
  _UpdateAdsState createState() => _UpdateAdsState(id);
}

class _UpdateAdsState extends State<UpdateAds> {
  final id;
  String apiToken;
  Map info = {};
  bool isLoading = true;
  Product product = new Product();
  ApiUrl api = new ApiUrl();
  final _titleCotnroller = TextEditingController();
  final _desController = TextEditingController();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  List<DropdownMenuItem> citiesDropdownItems = [];
  List cities = [];
  String cityId;
  Set<Marker> _markers = {};
  String location = "";
  double lat, lng;

  List<TextEditingController> textFields;
  List textFieldsNames;
  bool hasTextFields = false;
  List dropFields;
  Map<String, String> dropFieldsNames;
  bool hasDropFields = false;
  Map checkFields;
  List checkFieldsNames;
  List checkFieldsValues = [];
  bool hasCheckFields = false;
  Map<String, List<bool>> checkStates = {};
  Map<String, String> checkLists = {};
  Map<String, String> radioList = {};
  bool hasRedioFields = false;
  List radioFields = [];
  List<File> images = [];
  bool hasImages = false;
  @override
  void initState() {
    getUpdateInfo();
    super.initState();
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("Gallery"),
                      onTap: () async {
                        // _imgFromGallery();
                        List<File> imgs = await product.pickImageFromGallery();
                        //bot.dialog(false, "", context);
                        Navigator.of(context).pop();
                        print(imgs[0].path);
                        setState(() {
                          images = imgs;
                          hasImages = true;
                        });
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'),
                    onTap: () async {
                      List<File> imgs = await product.pickImageFromCamera();
                      //bot.dialog(false, "", context);
                      Navigator.of(context).pop();
                      setState(() {
                        images = imgs;
                        hasImages = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getFieldsList() async {
    //print(map);
    Map data = {};
    data['data'] = info;
    String fields = jsonEncode(data);
    setState(() {
      textFields = product.getTextFields(fields);
      textFieldsNames = product.getTextFieldsNames(fields);
      dropFields = product.getDropFields(fields);
      dropFieldsNames = product.getDropValues(fields);
      checkFieldsNames = product.getCheckFieldsNames(fields);
      checkFields = product.getCheckFields(fields);
      checkLists = product.getCheckLists(fields);
      radioFields = product.getRadioFields(fields);

      cities = product.getAdCities(fields);
      getCitiesDropItems();
      initRadioValues();
      initCheckBoxValues();
      hasCheckFields = true;
      hasTextFields = true;
      hasRedioFields = true;
      if (dropFields != null && dropFields.length > 0) hasDropFields = true;
    });
  }

  void initCheckBoxValues() {
    for (var item in checkFieldsNames) {
      checkStates[item['name']] = [];
      List values = item['details'].split(",");
      for (var value in values) {
        checkStates[item['name']].add(false);
      }
    }
  }

  void initRadioValues() {
    for (var item in radioFields) {
      radioList[item['name']] = "";
    }
  }

  void getCitiesDropItems() {
    citiesDropdownItems.clear();
    for (var city in cities) {
      setState(() {
        citiesDropdownItems.add(DropdownMenuItem(
            child: Text(city['name']), value: city['id'].toString()));
      });
    }
  }

  void getUpdateInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = prefs.getString("apiToken");
    });
    Map inf = await product.getUpdateInfo(id, apiToken);
    setState(() {
      info = inf;
      print(info);
      _titleCotnroller.text = info['ad']['title'];
      _desController.text = info['ad']['body'];
      _priceController.text = info['ad']['price'].toString();
      location = info['ad']['location'];
      cityId = info['ad']['city_id'].toString();
      List latlng = location.split(",");
      lat = double.parse(latlng[0]);
      lng = double.parse(latlng[1]);
      isLoading = false;
    });

    getFieldsList();
  }

  _onTap(LatLng latLng) {
    location = latLng.latitude.toString() + "," + latLng.longitude.toString();
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(lat, lng),
        ),
      );
    });
  }

  Widget getRadioValues(String radio, String name) {
    List values = radio.split(",");
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      slivers: [
        SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Row(
                children: [
                  Radio(
                      value: values[index],
                      groupValue: radioList[name],
                      onChanged: (value) {
                        setState(() {
                          radioList[name] = value;
                        });
                        print(radioList);
                      }),
                  Expanded(child: Text(values[index]))
                ],
              );
            }, childCount: values.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 0.0, childAspectRatio: 1.5))
      ],
    );
  }

  Widget getCheckValues(String check, String name) {
    List values = check.split(",");

    //print(checkStates);
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Checkbox(
                          value: checkStates[name][index],
                          onChanged: (value) {
                            if (value)
                              checkLists[name] += (values[index]) + ",";
                            else {
                              List itms = checkLists[name].split(",");
                              for (var val in itms)
                                if (val == value) itms.remove(val);
                              for (var val in itms)
                                checkLists[name] += val + ",";
                            }

                            setState(() {
                              checkStates[name][index] = value;
                            });
                            //print(checkLists);
                          }),
                      Expanded(child: Text(values[index]))
                    ],
                  ),
                );
              },
              childCount: values.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 0.0, childAspectRatio: 1.5))
      ],
    );
  }

  List<DropdownMenuItem> getDropdownItems(String json) {
    var res = json.split(",");
    List<DropdownMenuItem> items = [];
    for (var item in res) {
      items.add(DropdownMenuItem(child: Text(item), value: item));
    }
    return items;
  }

  void submitAdUpdate() async {
    SnackBar snackBar = SnackBar(
      content: Row(children: [
        CircularProgressIndicator(color: Colors.orange),
        SizedBox(
          width: 10,
        ),
        Text("Updating ads")
      ]),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Map<String, String> items = {};
    items['title'] = _titleCotnroller.text;
    items['desc'] = _desController.text;
    items['phone'] = _phoneController.text;
    items['price'] = _priceController.text;
    items['location'] = location;
    items['city_id'] = cityId;
    int i = 0;
    if (hasTextFields)
      while (i < textFieldsNames.length) {
        items[textFieldsNames[i]] = textFields[i].text;
        i++;
      }
    if (hasCheckFields) {
      for (var name in checkFieldsNames) {
        print(name['name']);
        String check = "[" + checkLists[name['name']] + "]";
        items[name['name']] = check;
      }
    }
    if (hasRedioFields) items.addAll(radioList);
    if (hasDropFields) items.addAll(dropFieldsNames);
    print(items);
    product.updateAd(apiToken, items, id, images, context);
  }

  _UpdateAdsState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.red,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0),
            centerTitle: true,
            title: Text("Update Ads"),
            automaticallyImplyLeading: true,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: hasImages
                                      ? FileImage(images[0])
                                      : NetworkImage(
                                          api.storageUrl + info['ad']['image']),
                                  fit: BoxFit.fill),
                              border:
                                  Border.all(width: 1, color: Colors.orange)),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showPicker(context);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            label: Text("Chnage Image",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Colors.black26),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _titleCotnroller,
                      decoration: InputDecoration(
                          labelText: "title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 1))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      minLines: 10,
                      maxLines: 50,
                      controller: _desController,
                      decoration: InputDecoration(
                          labelText: "Descreption",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 1))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 1))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 1))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        items: citiesDropdownItems,
                        value: cityId,
                        hint: Text("city"),
                        onChanged: (value) {
                          setState(() {
                            cityId = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 1)))),
                    SizedBox(height: 20),
                    //google map
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: GoogleMap(
                          onTap: _onTap,
                          onMapCreated: _onMapCreated,
                          markers: _markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat, lng),
                            zoom: 15,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    hasTextFields
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: textFields.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  TextField(
                                    controller: textFields[index],
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.orange)),
                                        labelText: textFieldsNames[index]),
                                  )
                                ],
                              );
                            })
                        : Container(),
                    hasDropFields
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: dropFields.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.orange))),
                                    hint: Text(dropFields[index]['name']),
                                    items: getDropdownItems(
                                        dropFields[index]['details']),
                                    onChanged: (value) {
                                      dropFieldsNames[dropFields[index]
                                          ['name']] = value;
                                    },
                                  ));
                            })
                        : Container(),
                    hasCheckFields
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: checkFieldsNames.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(children: [
                                Text(
                                  checkFieldsNames[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                getCheckValues(
                                    checkFieldsNames[index]['details'],
                                    checkFieldsNames[index]['name'])
                              ]);
                            })
                        : Container(),
                    hasRedioFields
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: radioFields.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: [
                                    Text(
                                      radioFields[index]['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    getRadioValues(
                                        radioFields[index]['details'],
                                        radioFields[index]['name'])
                                  ],
                                ),
                              );
                            })
                        : Container(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ElevatedButton(
                          onPressed: () {
                            submitAdUpdate();
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)))),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              ),
            ),
    );
  }
}
