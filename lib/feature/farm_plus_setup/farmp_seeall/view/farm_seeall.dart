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
import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/subcategory_expanded_view.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/feature/farm_plus_setup/view/widgets/image_section.dart';
import 'package:farm_system/feature/farm_plus_setup/view/widgets/images_list.dart';
import 'package:farm_system/feature/farm_plus_setup/view/widgets/options_button.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class FarmSeeAllPage extends StatefulWidget {
  final categoryName;
  final categoryId;
  final subCategory;

  FarmSeeAllPage(
      {Key key, this.categoryName, this.categoryId, this.subCategory})
      : super(key: key);

  @override
  _FarmSeeAllPageState createState() => _FarmSeeAllPageState();
}

class _FarmSeeAllPageState extends State<FarmSeeAllPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        selectedIndex = 0;
                      });
                    },
                  ),
                  title: Container(
                    child: FarmSearchBarNew(
                      categoryName: widget.categoryName,
                    ),
                  ),
                ),
                backgroundColor: Colors.black,
                body: SingleChildScrollView(
                    child: Consumer(builder: (context, watch, child) {
                  // ignore: non_constant_identifier_names
                  final FarmPlusRepo = watch(farmPlusProvider);
                  return AsyncLoader(
                      initState: () => FarmPlusRepo.farmCategory(
                            widget.categoryId,
                          ),
                      renderLoad: () => AllElementShimmer(),
                      renderError: ([err]) => Text('There was a error'),
                      renderSuccess: ({data}) => Column(
                            children: [
                              Container(
                                height: 50,
                                margin: EdgeInsets.all(10),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: FarmPlusRepo
                                        .categoryPostPic.post.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        height: 20,
                                        margin: EdgeInsets.all(2),
                                        child: RaisedButton(
                                          color: Colors.transparent,
                                          onPressed: () {
                                            setState(() {
                                              selectedIndex = 0;
                                            });
                                            navigationToScreen(
                                                context,
                                                SubCategoryExpandedView(
                                                  categoryId: FarmPlusRepo
                                                      .categoryPostPic
                                                      .post[i]
                                                      .categoryId,
                                                  subCategory: FarmPlusRepo
                                                      .categoryPostPic
                                                      .post[i]
                                                      .categoryName,
                                                  categoryName: FarmPlusRepo
                                                      .categoryPostPic
                                                      .post[i]
                                                      .categoryName,
                                                ),
                                                false);
                                          },
                                          child: FarmPlusRepo.categoryPostPic
                                                  .post[i].categoryName.isEmpty
                                              ? Text(
                                                  'EMPTY',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  FarmPlusRepo.categoryPostPic
                                                      .post[i].categoryName
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 3,
                                                color: selectedIndex == i
                                                    ? Colors.pink
                                                    : Colors.transparent),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      FarmPlusRepo.categoryPostPic.post.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: FarmPlusRepo
                                                        .categoryPostPic
                                                        .post[index]
                                                        .categoryName
                                                        .isEmpty
                                                    ? Text(
                                                        'Empty',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    : Text(
                                                        FarmPlusRepo
                                                                .categoryPostPic
                                                                .post[index]
                                                                .categoryName[0]
                                                                .toUpperCase() +
                                                            FarmPlusRepo
                                                                .categoryPostPic
                                                                .post[index]
                                                                .categoryName
                                                                .substring(1),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 10.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      navigationToScreen(
                                                          context,
                                                          SubCategoryExpandedView(
                                                              categoryId: FarmPlusRepo
                                                                  .categoryPostPic
                                                                  .post[index]
                                                                  .categoryId,
                                                              subCategory: FarmPlusRepo
                                                                  .categoryPostPic
                                                                  .post[index]
                                                                  .categoryName,
                                                              categoryName: FarmPlusRepo
                                                                  .categoryPostPic
                                                                  .post[index]
                                                                  .categoryName,
                                                          ),
                                                          false);
                                                    },
                                                    child: Text(
                                                      'See All',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            HexColor("D41B47"),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 150,
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 15),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: FarmPlusRepo
                                                  .categoryPostPic
                                                  .post[index]
                                                  .categoryContent
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i1) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    print('seeAll expanded');
                                                    navigationToScreen(
                                                        context,
                                                        VideoExpandedPage(
                                                          categoryName:
                                                              FarmPlusRepo
                                                                  .categoryPostPic
                                                                  .post[index]
                                                                  .categoryName,
                                                          imageurl: FarmPlusRepo
                                                              .categoryPostPic
                                                              .post[index]
                                                              .categoryContent[
                                                                  i1]
                                                              .thumbnailUrl,
                                                          title: FarmPlusRepo
                                                              .categoryPostPic
                                                              .post[index]
                                                              .categoryContent[
                                                                  i1]
                                                              .title,
                                                          bodyText: FarmPlusRepo
                                                              .categoryPostPic
                                                              .post[index]
                                                              .categoryContent[
                                                                  i1]
                                                              .title,
                                                          filepath: FarmPlusRepo
                                                              .categoryPostPic
                                                              .post[index]
                                                              .categoryContent[
                                                                  i1]
                                                              .videoUrl,
                                                        ),
                                                        false);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 250,
                                                        height: 150,
                                                        child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: FarmPlusRepo
                                                                      .categoryPostPic
                                                                      .post[
                                                                          index]
                                                                      .categoryContent[
                                                                          i1]
                                                                      .thumbnailUrl ==
                                                                  null
                                                              ? Container(
                                                            color: Colors.black,
                                                            child: Center(
                                                              child: Text(
                                                                'No Video in the particular post',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ) : CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: getImageUrl(FarmPlusRepo
                                                                      .categoryPostPic
                                                                      .post[
                                                                          index]
                                                                      .categoryContent[
                                                                          i1]
                                                                      .thumbnailUrl)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ))
                                      ],
                                    );
                                  }),
                            ],
                          ));
                })))));
  }
}

class FarmSearchBarNew extends ConsumerWidget {
  final categoryName;

  FarmSearchBarNew({Key key, @required this.categoryName}) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
    TextEditingController _Controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      height: 40,
      //color: Colors.grey,
      margin: EdgeInsets.only(
        left: 0,
        right: 10,
        top: 10,
      ),
      child: TextFormField(
        controller: _Controller,
        showCursor: false,
        cursorColor: Colors.white,
        onChanged: (value) {},
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search $categoryName',
          contentPadding: EdgeInsets.only(bottom: 2, top: 4),
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
