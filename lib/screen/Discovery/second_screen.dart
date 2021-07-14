// import 'package:flutter/material.dart';
// import 'package:native_device_orientation/native_device_orientation.dart';
//
//
//
// class SecondScreen extends StatefulWidget {
//   @override
//   _SecondScreenState createState() => new _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   bool useSensor = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//           appBar: new AppBar(
//             title: new Text('Native Orientation example app'),
//             actions: <Widget>[Switch(value: useSensor, onChanged: (val) => setState(() => useSensor = val))],
//           ),
// // encapsulating your Screen UI with NativeDeviceOrientationReader is must.
//           body: NativeDeviceOrientationReader(
//             builder: (context) {
//               NativeDeviceOrientation orientation = NativeDeviceOrientationReader.orientation(context);
//               print("Received new orientation: $orientation");
//               return Center(child: Text('Native Orientation: $orientation\n'));
//             },
//             useSensor: useSensor,
//           ),
//           floatingActionButton: Builder(
//             builder: (context) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   FloatingActionButton(
//                     child: Text("Sensor"),
//                     onPressed: () async {
//                       NativeDeviceOrientation orientation =
//                       await NativeDeviceOrientationCommunicator().orientation(useSensor: true);
//                       Scaffold.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Native Orientation read: $orientation"),
//                           duration: Duration(milliseconds: 500),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   FloatingActionButton(
//                     child: Text("UI"),
//                     onPressed: () async {
//                       NativeDeviceOrientation orientation =
//                       await NativeDeviceOrientationCommunicator().orientation(useSensor: false);
//                       Scaffold.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Native Orientation read: $orientation"),
//                           duration: Duration(milliseconds: 500),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:farm_system/screen/imagefile.dart';
// import 'package:flutter/material.dart';
// import 'package:storage_path/storage_path.dart';

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Instagrm picker demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<FileModel> files;
//   FileModel selectedModel;
//   String image;
//   @override
//   void initState() {
//     super.initState();
//     getImagesPath();
//   }
//
//   getImagesPath() async {
//     var imagePath = await StoragePath.imagesPath;
//     var images = jsonDecode(imagePath) as List;
//     files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
//     if (files != null && files.length > 0)
//       setState(() {
//         selectedModel = files[0];
//         image = files[0].files[0];
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Icon(Icons.clear),
//                     SizedBox(width: 10),
//                     DropdownButtonHideUnderline(
//                         child: DropdownButton<FileModel>(
//                           items: getItems(),
//                           onChanged: (FileModel d) {
//                             assert(d.files.length > 0);
//                             image = d.files[0];
//                             setState(() {
//                               selectedModel = d;
//                             });
//                           },
//                           value: selectedModel,
//                         ))
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Next',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 )
//               ],
//             ),
//             Divider(),
//             Container(
//                 height: MediaQuery.of(context).size.height * 0.45,
//                 child: image != null
//                     ? Image.file(File(image),
//                     height: MediaQuery.of(context).size.height * 0.45,
//                     width: MediaQuery.of(context).size.width)
//                     : Container()),
//             Divider(),
//             selectedModel == null && selectedModel.files.length < 1
//                 ? Container()
//                 : Container(
//               height: MediaQuery.of(context).size.height * 0.38,
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 4,
//                       mainAxisSpacing: 4),
//                   itemBuilder: (_, i) {
//                     var file = selectedModel.files[i];
//                     return GestureDetector(
//                       child: Image.file(
//                         File(file),
//                         fit: BoxFit.cover,
//                       ),
//                       onTap: () {
//                         setState(() {
//                           image = file;
//                         });
//                       },
//                     );
//                   },
//                   itemCount: selectedModel.files.length),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<DropdownMenuItem> getItems() {
//     return files
//         .map((e) => DropdownMenuItem(
//       child: Text(
//         e.folder,
//         style: TextStyle(color: Colors.black),
//       ),
//       value: e,
//     ))
//         .toList() ??
//         [];
//   }
// }
import 'package:farm_system/screen/Discovery/scrollin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all_element.dart';
import 'main_image_section.dart';

// ignore: must_be_immutable
class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              MainImageSection(),
              SizedBox(
                height: 5,
              ),
              ScrollingButton(),
              SizedBox(
                height: 10.0,
              ),
              AllElementListView(),
            ],
          ),
        ));
  }
}
