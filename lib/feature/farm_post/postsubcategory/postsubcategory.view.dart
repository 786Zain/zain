import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/animation/animation.dart';
import 'package:farm_system/feature/farm_post/farm_post.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/postcategory.repo.dart';
import 'package:farm_system/feature/farm_post/postsubcategory/postsubcategory.model.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';

class PostSubCategoryView extends StatefulWidget {
  final String id;
  final String categoryName;
  final String textTyped;
  final File filePath;

  const PostSubCategoryView(
      {Key key, this.id, this.categoryName, this.textTyped, this.filePath})
      : super(key: key);

  @override
  _PostSubCategoryViewState createState() => _PostSubCategoryViewState();
}

class _PostSubCategoryViewState extends State<PostSubCategoryView> {
  TextEditingController editingController = TextEditingController();

  final _asyncKeySubCategory = GlobalKey<AsyncLoaderState>();
  String _keyWord = '';

  String saveSearch;
  String subCateId;
  String newSave;
  bool isFound = true;

  bool postShow = false;

  @override
  void initState() {
    super.initState();
    // saveSearch = editingController.text;

    // setState(() {
    //   isFound = true;
    // });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final subPostCategory = context.read(subPostCategoryProvider);
      subPostCategory.resetSubCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    // void goToNextPage() {
    //   setState(() {
    //     isFound=true;
    //   });
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Consumer(builder: (context, watch, child) {
            final subCategoryProviderRepo = watch(subPostCategoryProvider);
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  Text(widget.categoryName.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2)),
                  GestureDetector(
                      child: Container(

                          // child: Text("Done",
                          //     style: GoogleFonts.montserrat(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.normal,
                          //         letterSpacing: 2))
                          ),
                      onTap: () async {
                        Navigator.of(context).push(Pagetransition(
                          widget: FarmPost(
                            categoryId: widget.id,
                            subcategoryId: subCateId,
                            id: widget.categoryName,
                            subCategory: saveSearch ?? editingController.text,
                            textTyped: widget.textTyped,
                            filePath: widget.filePath,
                          ),
                        ));
                        // await postProviderRepo.createPost(
                        //     widget.filePath, _captionController.text);
                        // AppNavigator.push(Routes.dashBoard);
                      })
                ]);
          })),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 24),
                child: Consumer(builder: (context, watch, child) {
                  final saveSearchProviderRepo = watch(saveSearchProvider);
                  final subCategoryProviderRepo =
                      watch(subPostCategoryProvider);

                  return Container(
                    height: 36,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(118, 118, 128, 0.12),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2),
                      textAlign: TextAlign.start,
                      // onSubmitted: (value) {
                      //   setState(() {
                      //     _keyWord = value;
                      //   });
                      //
                      //
                      //
                      //   saveSearchProviderRepo.postSearchCategory(_keyWord, widget.id);
                      // } ,
                      // onChanged: (value) {
                      //   setState(() {
                      //     _keyWord = value;
                      //   });
                      //
                      //   print(_keyWord);
                      //   //showSearch(context: context, delegate: DataSearch());
                      //   saveSearchProviderRepo.postSearchCategory(_keyWord, widget.id);
                      // },
                      onChanged: (value) {
                        //subCategoryProviderRepo.searchText;
                        setState(() {});
                        bool textFound = true;
                        subCategoryProviderRepo.feedSubCategory.forEach((cate) {
                          postShow = true;
                          if (editingController.text == cate.subCategoryName) {
                            textFound = false;
                          }
                        });
                        isFound = textFound;
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: GoogleFonts.lato(
                              fontSize: 17, color: Colors.white),
                          // contentPadding: EdgeInsets.fromLTRB(7.2,6,0,9),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 10),
                            child: Icon(
                              Icons.search,
                              // color: Color.fromRGBO(0, 0, 0, 1),
                              color: Colors.white,
                            ),
                          )),
                    ),
                  );
                }),
              ),
              Consumer(builder: (context, watch, child) {
                final subCategoryProviderRepo = watch(subPostCategoryProvider);

                return AsyncLoader(
                    key: _asyncKeySubCategory,
                    initState: () =>
                        subCategoryProviderRepo.getSubCategoryPost(widget.id),
                    renderLoad: () => CircularProgressIndicator(),
                    renderError: ([err]) => Text('There was a error'),
                    renderSuccess: ({data}) => SingleChildScrollView(
                          child: _generateUI(),
                        ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Consumer _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final subCategoryProviderRepo = watch(subPostCategoryProvider);
      final saveSearchProviderRepo = watch(saveSearchProvider);
      return SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                subCateId = subCategoryProviderRepo
                    .feedSubCategory[0].id;
                await  Navigator.of(context).push(Pagetransition(
                  widget: FarmPost(
                    categoryId: widget.id,
                    subcategoryId: subCateId,
                    id: widget.categoryName,
                    subCategory: saveSearch ?? editingController.text,
                    textTyped: widget.textTyped,
                    filePath: widget.filePath,
                  ),
                ));
              },
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: isFound
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              editingController.text.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 2),
                            ),
                            //   Text("${categoryProviderRepo.feedCategory[index].postCount.toString()} posts")
                          ],
                        )
                      : Container(),
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: subCategoryProviderRepo.feedSubCategory.length,
                itemBuilder: (BuildContext context, index) {
                  if (editingController.text.isEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Container(
                            color: Colors.black,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async{
                                setState(() {
                                  postShow = true;
                                });
                                subCateId = subCategoryProviderRepo.feedSubCategory[index].id;
                              await  Navigator.of(context).push(Pagetransition(
                                  widget: FarmPost(
                                    categoryId: widget.id,
                                    subcategoryId: subCateId,
                                    id: widget.categoryName,
                                    subCategory: subCategoryProviderRepo
                                        .feedSubCategory[index].subCategoryName,
                                    // saveSearch ?? editingController.text,
                                    textTyped: widget.textTyped,
                                    filePath: widget.filePath,
                                  ),
                                ));

                                // subCateId = subCategoryProviderRepo
                                //     .feedSubCategory[index].id;
                                // saveSearch = subCategoryProviderRepo
                                //     .feedSubCategory[index].subCategoryName;
                                // editingController.text = saveSearch;
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subCategoryProviderRepo
                                        .feedSubCategory[index].subCategoryName
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
                  } else if (subCategoryProviderRepo
                      .feedSubCategory[index].subCategoryName
                      .toLowerCase()
                      .contains(editingController.text)) {
                    return Column(
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   subCategoryProviderRepo
                                //       .feedSubCategory[index].subCategoryName,
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                // Text("${categoryProviderRepo.feedCategory[index].postCount.toString()} posts")
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              postShow = true;
                              subCateId = subCategoryProviderRepo
                                  .feedSubCategory[index].id;
                              saveSearch = subCategoryProviderRepo
                                  .feedSubCategory[index].subCategoryName;
                              editingController.text = saveSearch;
                            });
                            // if(editingController.text == subCategoryProviderRepo.subCategory[index].subCategoryName){
                            //   print("other value");
                            // }else{
                            //   print("no value");
                            // }
                            // serachSave = subCategoryProviderRepo.subCategory[index].subCategoryName;
                            // saveSearchProviderRepo.postSearchCategory(subCategoryProviderRepo.subCategory[index].subCategoryName, widget.id);
                          },
                        ),
                        Divider(),
                      ],
                    );

                    //   GestureDetector(
                    //   child: Text('${subCategoryProviderRepo.subCategory[index].subCategoryName}'
                    //
                    //   ),
                    //   onTap: (){
                    //     print("value");
                    //     print(subCategoryProviderRepo.subCategory[index].subCategoryName);
                    //     setState(() {
                    //       saveSearch = subCategoryProviderRepo.subCategory[index].subCategoryName;
                    //       editingController.text = saveSearch;
                    //     });
                    //     // if(editingController.text == subCategoryProviderRepo.subCategory[index].subCategoryName){
                    //     //   print("other value");
                    //     // }else{
                    //     //   print("no value");
                    //     // }
                    //    // serachSave = subCategoryProviderRepo.subCategory[index].subCategoryName;
                    //    // saveSearchProviderRepo.postSearchCategory(subCategoryProviderRepo.subCategory[index].subCategoryName, widget.id);
                    //   },
                    // );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      );
    });
  }
}
