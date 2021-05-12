import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:easy/presentation/page/forget.dart';
import 'package:easy/presentation/widgets/ProductDetails/LocationSection.dart';
import 'package:easy/presentation/widgets/FormInput/ImageInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class ProductDetailsForm extends StatefulWidget {
  @override
  _ProductDetailsFormState createState() => _ProductDetailsFormState();
}

class _ProductDetailsFormState extends State<ProductDetailsForm> {
  int _selectedCity = 0;
  int flag = 0;

  List<DropdownMenuItem<int>> dropItemsList = [];

  void loadItemsList(String itemType) {
    dropItemsList = [];
    if (itemType == 'cities') {
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Damascus'),
        value: 0,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Aleppo'),
        value: 1,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Swaida'),
        value: 2,
      ));
    } else if (itemType == 'mainCategories') {
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Main Category 1'),
        value: 0,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Main Category 2'),
        value: 1,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Main Category 3'),
        value: 2,
      ));
    } else if (itemType == 'subCategories') {
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Sub Category 1'),
        value: 0,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Sub Category 2'),
        value: 1,
      ));
      dropItemsList.add(new DropdownMenuItem(
        child: new Text('Sub Category 3'),
        value: 2,
      ));
    }
  }

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null,
    'phoneNumber': null,
    'city': null,
    'location': null
  };

  Widget _buildTitleRow() {
    return Container(
      child: Text(
        'Post Ad',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _buildAdTitleTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Ad title',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
      ),
      // initialValue: widget.product == null ? '' : widget.product['title'],
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }
      },
      onSaved: (String value) {
        setState(() {
          _formData['title'] = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        alignLabelWithHint: true,
      ),
      // initialValue: widget.product == null ? '' : widget.product['title'],
      maxLines: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        }
      },
      onSaved: (String value) {
        setState(() {
          _formData['description'] = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
      ),
      // initialValue: widget.product == null ? '' : widget.product['price'].toString(),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildPhoneNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Contact phone number',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
      ),
      // initialValue: widget.product == null ? '' : widget.product['price'].toString(),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Phone is required';
        }
      },
      onSaved: (String value) {
        _formData['phoneNumber'] = double.parse(value);
      },
    );
  }

  Widget _buildCitiesDropDownList(String dropItem, String itemType) {
    loadItemsList(itemType);
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 1),
        ),
      ),

      hint: new Text('Select $dropItem'),
      items: dropItemsList,
      // value: _selectedCity,
      onChanged: (value) {
        setState(() {
          switch (value) {
            case 0:
              flag = 1;
              break;
            case 1:
              flag = 2;
              break;
            default:
              flag = 0;
          }
          _selectedCity = value;
        });
      },

      isExpanded: true,
    );
  }

  int _currentStep = 0;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  String _country = "city1";
  String _category = "city1";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Form(
          child: ListView(
            children: [
              Stepper(
                  type: StepperType.vertical,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('Ad info'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Ad title',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              minLines: 10,
                              maxLines: 50,
                              decoration: InputDecoration(
                                  labelText: 'Description',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)))),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Price',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)))),
                        ],
                      ),
                      isActive: _currentStep == 0,
                    ),
                    Step(
                      title: Text("Ads Image"),
                      content: Container(
                        child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt),
                            label: Text("Add Image")),
                      ),
                      isActive: _currentStep == 1,
                    ),
                    Step(
                        title: Text("Contact info"),
                        content: Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Contact Phone Number',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1))),
                          ),
                        ),
                        isActive: _currentStep == 2),
                    Step(
                        title: Text("Location"),
                        content: Container(
                          child: DropdownButtonFormField(
                            value: _country,
                            decoration: InputDecoration(
                                labelText: "Choose language",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.orange))),
                            items: [
                              DropdownMenuItem(
                                child: Text("Syria"),
                                value: "city1",
                              ),
                              DropdownMenuItem(
                                child: Text("UAE"),
                                value: "city2",
                              ),
                              DropdownMenuItem(
                                child: Text("Saudi Arabia"),
                                value: "city3",
                              )
                            ],
                            onChanged: (value) {
                              _country = value;
                            },
                          ),
                        ),
                        isActive: _currentStep == 3),
                    Step(
                        title: Text("Category"),
                        content: Container(
                          child: DropdownButtonFormField(
                            value: _category,
                            decoration: InputDecoration(
                                labelText: "Choose Category",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.orange))),
                            items: [
                              DropdownMenuItem(
                                child: Text("Motors"),
                                value: "city1",
                              ),
                              DropdownMenuItem(
                                child: Text("Properties"),
                                value: "city2",
                              ),
                              DropdownMenuItem(
                                child: Text("jobs"),
                                value: "city3",
                              )
                            ],
                            onChanged: (value) {
                              _category = value;
                            },
                          ),
                        ),
                        isActive: _currentStep == 4)
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
