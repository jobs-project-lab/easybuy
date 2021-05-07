import 'package:easy/presentation/page/forget.dart';
import 'package:easy/presentation/widgets/ProductDetails/LocationSection.dart';
import 'package:easy/presentation/widgets/FormInput/ImageInput.dart';
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
              _buildTitleRow(),
              SizedBox(height: 30),
              _buildAdTitleTextFormField(),
              SizedBox(height: 10),
              _buildDescriptionTextFormField(),
              SizedBox(height: 10),
              _buildPriceTextField(),
              SizedBox(height: 10),
              _buildPhoneNumberTextField(),
              SizedBox(height: 10),
              _buildCitiesDropDownList('City', 'cities'),
              SizedBox(height: 10),
              ImageInput(),
              SizedBox(
                height: 10,
              ),
              LocationSection(),
              SizedBox(
                height: 10,
              ),
              _buildCitiesDropDownList('Category', 'mainCategories'),
              SizedBox(
                height: 10,
              ),
              flag > 0
                  ? _buildCitiesDropDownList('Category', 'subCategories')
                  : SizedBox(
                      height: 40,
                    ),
              SizedBox(
                height: 10,
              ),
              flag == 2
                  ? _buildCitiesDropDownList('Category', 'subCategories')
                  : SizedBox(
                      height: 40,
                    ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
