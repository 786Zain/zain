import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/feature/farm_post/postcategory/postcategory.model.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/postsubcategory.view.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectCategoryPost extends StatefulWidget {
  final String textTyped;
  final File filePath;

  const SelectCategoryPost({Key key, this.textTyped, this.filePath})
      : super(key: key);

  @override
  _SelectCategoryPostState createState() => _SelectCategoryPostState();
}

class _SelectCategoryPostState extends State<SelectCategoryPost> {
  final _asyncKeyCategory = GlobalKey<AsyncLoaderState>();

  TextEditingController searchCategory = TextEditingController();

  String categorySearchMain;
  String categoryid;

  bool postShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Consumer(builder: (context, watch, child) {
              final categoryProviderRepo = watch(postCategoryProvider);
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                    // postShow ?  GestureDetector(
                    //     child: Container(
                    //         child: Text("POST",
                    //             style: GoogleFonts.montserrat(
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.normal,
                    //                 wordSpacing: 2,
                    //                 letterSpacing: 2))),
                    //     onTap: () async {
                    //       print("posting");
                    //       // await postProviderRepo.createPost(
                    //       //     widget.filePath, _captionController.text);
                    //       // AppNavigator.push(Routes.dashBoard);
                    //       Navigator.of(context).push(Pagetransition(
                    //         widget: PostSubCategoryView(
                    //           id: categoryid,
                    //           categoryName : categorySearchMain,
                    //             textTyped: widget.textTyped,
                    //             filePath: widget.filePath
                    //         ),
                    //       ));
                    //     }) : Container(
                    //     child: Text("POST",
                    //         style: GoogleFonts.montserrat(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.normal,
                    //             wordSpacing: 2,
                    //             letterSpacing: 2))),
                  ]);
            })),
        body: Container(
          child: Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(left: 20, right: 20, top: 24),
              //   child: Container(
              //     height: 36,
              //     decoration: BoxDecoration(
              //         color: Color.fromRGBO(118, 118, 128, 0.12),
              //         borderRadius: BorderRadius.circular(10.0)),
              //     child: TextField(
              //       style: GoogleFonts.lato(
              //           fontSize: 17,
              //        //   color: Color.fromRGBO(25, 32, 56, 1)
              //           color: Colors.white
              //       ),
              //       textAlign: TextAlign.start,
              //       // onChanged: (value) {
              //       //   setState(() {
              //       //     _keyWord = value;
              //       //   });
              //       //   showSearch(context: context, delegate: DataSearch());
              //       // },
              //       onChanged: (value) {
              //         setState(() {});
              //       },
              //       controller: searchCategory,
              //       decoration: InputDecoration(
              //           hintText: "Search",
              //           hintStyle:
              //           GoogleFonts.lato(fontSize: 17, color: Colors.grey),
              //           // contentPadding: EdgeInsets.fromLTRB(7.2,6,0,9),
              //           border: InputBorder.none,
              //           prefixIcon: Padding(
              //             padding: const EdgeInsets.only(right: 20, left: 10),
              //             child: Icon(
              //               Icons.search,
              //               // color: Color.fromRGBO(0, 0, 0, 1),
              //               color: Colors.white
              //             ),
              //           )),
              //     ),
              //   ),
              // ),
              Consumer(builder: (context, watch, child) {
                final categoryProviderRepo = watch(postCategoryProvider);
                return AsyncLoader(
                  key: _asyncKeyCategory,
                  initState: () => categoryProviderRepo.getCategoryPost(),
                  renderLoad: () => CircularProgressIndicator(),
                  renderError: ([err]) => Text('There was a error'),
                  renderSuccess: ({data}) => _generateUI(),
                );
              }),
            ],
          ),
        ));
  }

  Consumer _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final categoryProviderRepo = watch(postCategoryProvider);
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: categoryProviderRepo.feedCategory.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Container(
                      color: Colors.black,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            Navigator.of(context).push(SlideFromRight(
                              widget: PostSubCategoryView(
                                  id: categoryProviderRepo
                                      .feedCategory[index].id,
                                  categoryName: categoryProviderRepo
                                      .feedCategory[index].categoryName,
                                  textTyped: widget.textTyped,
                                  filePath: widget.filePath),
                            ));
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryProviderRepo
                                  .feedCategory[index].categoryName
                                  .toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
              // if(searchCategory.text.isEmpty){
              //   return  Column(
              //     children: [
              //       GestureDetector(
              //         child: Padding(
              //           padding: EdgeInsets.only(left: 20, right: 20,top: 10),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(categoryProviderRepo.feedCategory[index].categoryName,
              //                 style: TextStyle(
              //                     color: Colors.white
              //                 ),
              //               ),
              //               //Text("${categoryProviderRepo.feedCategory[index].postCount.toString()} posts")
              //             ],
              //           ),
              //         ),
              //         onTap: ()async{
              //           setState(() {
              //             postShow=true;
              //             categoryid = categoryProviderRepo.feedCategory[index].id.toString();
              //             categorySearchMain = categoryProviderRepo.feedCategory[index].categoryName;
              //             //For assigning the category list value to in the seach text when we select list item
              //             searchCategory.text = categorySearchMain;
              //
              //           });
              //         },
              //       ),
              //       Divider(),
              //     ],
              //   );
              //     //Text('${categoryProviderRepo.feedCategory[index].categoryName}');
              // } else if(
              // categoryProviderRepo.feedCategory[index].categoryName.toLowerCase().contains(searchCategory.text)
              //
              // ){
              //   return Column(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(left: 20, right: 20,top: 10),
              //         child: GestureDetector(
              //           onTap: ()  {
              //
              //             setState(() {
              //               postShow=true;
              //               categoryid = categoryProviderRepo.feedCategory[index].id.toString();
              //               categorySearchMain = categoryProviderRepo.feedCategory[index].categoryName;
              //               //For assigning the category list value to in the seach text when we select list item
              //               // searchCategory.text = categorySearchMain;
              //             });
              //             // Navigator.of(context).push(Pagetransition(
              //             //   widget: PostSubCategoryView(
              //             //     id: categoryProviderRepo.feedCategory[index].id,
              //             //     categoryName : categoryProviderRepo.feedCategory[index].categoryName,
              //             //   ),
              //             // ));
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(categoryProviderRepo.feedCategory[index].categoryName,
              //               style: TextStyle(
              //                 color: Colors.white
              //               ),
              //               ),
              //               Text("${categoryProviderRepo.feedCategory[index].postCount.toString()} posts")
              //             ],
              //           ),
              //         ),
              //       ),
              //       Divider(),
              //     ],
              //   );
              // }else{
              //   return Container();
              // }
            }),
      );
    });
  }
}
