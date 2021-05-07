import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Text('Use Camera'),
                  textColor: Colors.deepOrange,
                ),
                FlatButton(
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text('Choose from gallery'),
                  textColor: Colors.deepOrange,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlineButton(
          onPressed: () {
            _openImagePicker(context);
          },
          disabledBorderColor: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        _imageFile == null
            ? Text('Please pick an image..')
            : Image.file(
                _imageFile,
                width: MediaQuery.of(context).size.width,
                height: 400,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
        SizedBox(height: 50,)
      ],
    );
  }
}
