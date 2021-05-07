// import 'dart:io';
//
// //import 'package:blog_app/models/ImageUploadModel.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
//
// class SingleImageUpload extends StatefulWidget {
//   @override
//   _SingleImageUploadState createState() {
//     return _SingleImageUploadState();
//   }
// }
//
// class _SingleImageUploadState extends State<SingleImageUpload> {
//   List<Object> images = List<Object>();
//   Future<File> _imageFile;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       images.add("Add Image");
//       images.add("Add Image");
//       images.add("Add Image");
//       images.add("Add Image");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           centerTitle: true,
//           title: const Text('Upload image'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: buildGridView(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildGridView() {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 3,
//       childAspectRatio: 1,
//       children: List.generate(images.length, (index) {
//         if (images[index] is ImageUploadModel) {
//           ImageUploadModel uploadModel = images[index];
//           return Card(
//             clipBehavior: Clip.antiAlias,
//             child: Stack(
//               children: <Widget>[
//                 Image.file(
//                   uploadModel.imageFile,
//                   width: 300,
//                   height: 300,
//                 ),
//                 Positioned(
//                   right: 5,
//                   top: 5,
//                   child: InkWell(
//                     child: Icon(
//                       Icons.remove_circle,
//                       size: 20,
//                       color: Colors.red,
//                     ),
//                     onTap: () {
//                       setState(() {
//                         images.replaceRange(index, index + 1, ['Add Image']);
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Card(
//             child: IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 _onAddImageClick(index);
//               },
//             ),
//           );
//         }
//       }),
//     );
//   }
//
//   Future _onAddImageClick(int index) async {
//     setState(() {
//       _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
//       getFileImage(index);
//     });
//   }
//
//   void getFileImage(int index) async {
// //    var dir = await path_provider.getTemporaryDirectory();
//
//     _imageFile.then((file) async {
//       setState(() {
//         ImageUploadModel imageUpload = new ImageUploadModel();
//         imageUpload.isUploaded = false;
//         imageUpload.uploading = false;
//         imageUpload.imageFile = file;
//         imageUpload.imageUrl = '';
//         images.replaceRange(index, index + 1, [imageUpload]);
//       });
//     });
//   }
// }
//
// class ImageUploadModel {
//   bool isUploaded;
//   bool uploading;
//   File imageFile;
//   String imageUrl;
//
//   ImageUploadModel({
//     this.isUploaded,
//     this.uploading,
//     this.imageFile,
//     this.imageUrl,
//   });
// }

// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:multi_image_picker/multi_image_picker.dart';
//
//
// class MulipleImagePicker extends StatefulWidget {
//   @override
//   _MulipleImagePickerState createState() => _MulipleImagePickerState();
// }
//
// class _MulipleImagePickerState extends State<MulipleImagePicker> {
//   List<Asset> images = <Asset>[];
//   String _error = 'No Error Dectected';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }
//
//   Future<void> loadAssets() async {
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       images = resultList;
//       _error = error;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Center(child: Text('Error: $_error')),
//             ElevatedButton(
//               child: Text("Pick images"),
//               onPressed: loadAssets,
//             ),
//             Expanded(
//               child: buildGridView(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }