import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/seeAllShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/expanded_grid.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hexcolor/hexcolor.dart';

class SeeAllPost extends StatefulWidget {
  final categoryId;
  final categoryName;

  SeeAllPost({Key key, @required this.categoryId, @required this.categoryName})
      : super(key: key);
  @override
  _SeeAllPostState createState() => _SeeAllPostState();
}

class _SeeAllPostState extends State<SeeAllPost> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final discoveryRepo = watch(discoveryProvider);
        final getsubCategoryRepos = watch(subCategoryProvider);
        print(widget.categoryId);
        print(widget.categoryName);
        var idString = widget.categoryId;
        final DiscoveryRepo = watch(discoveryProvider);
        return AsyncLoader(
          initState: () => getsubCategoryRepos.getSubCategoryDscover(idString),
          renderLoad: () => SeeAllShimmer(),
          // Container(
          // height: MediaQuery.of(context).size.height, width:MediaQuery.of(context).size.width ,
          // child: SeeAllShimmer()),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          child: RaisedButton(
                            color: Colors.transparent,
                            onPressed: () {},
                            child: Text(
                              'All',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 3, color: Colors.pink),
                            ),
                          ),
                        ),
                        Container(
                          width: 240,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: getsubCategoryRepos
                                  .discoverySubList[0].subCategoryList.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  height: 20,
                                  margin: EdgeInsets.all(10),
                                  child: RaisedButton(
                                    color: Colors.transparent,
                                    onPressed: () {
                                      navigationToScreen(
                                          context,
                                          ExpandedView(
                                              categoryName: widget.categoryName,
                                              subcategoryName:
                                                  getsubCategoryRepos
                                                      .newFeedVar[i]
                                                      .subCategoryName,
                                              dataForpage: getsubCategoryRepos
                                                  .newFeedVar[i]),
                                          false);
                                    },
                                    child: Text(
                                      getsubCategoryRepos.discoverySubList[0]
                                          .subCategoryList[i].subCategoryName,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 3, color: Colors.transparent),
                                      // bottom: BorderSide(
                                      //     width: 3,
                                      //     color: selectedIndex == i
                                      //         ? Colors.pink
                                      //         : Colors.transparent),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: getsubCategoryRepos.newFeedVar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    getsubCategoryRepos.discoverySubList[0]
                                        .feeds[index].subCategoryName,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        navigationToScreen(
                                            context,
                                            ExpandedView(
                                                categoryName:
                                                    widget.categoryName,
                                                subcategoryName:
                                                    getsubCategoryRepos
                                                        .newFeedVar[index]
                                                        .subCategoryName,
                                                dataForpage: getsubCategoryRepos
                                                    .newFeedVar[index]),
                                            false);
                                      },
                                      child: Text(
                                        'See All',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: HexColor("D41B47"),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 150,
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: getsubCategoryRepos
                                    .newFeedVar[index].postFeeds.length,
                                itemBuilder: (BuildContext context, int i1) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPost(
                                                    isFromDiscover: true,
                                                    id: getsubCategoryRepos
                                                        .newFeedVar[index]
                                                        .postFeeds[i1]
                                                        .id,
                                                    hideImage:
                                                        getsubCategoryRepos
                                                            .newFeedVar[index]
                                                            .postFeeds[i1]
                                                            .textFeed,
                                                    // discoverySeeAll: getsubCategoryRepos
                                                    //     .newFeedVar[index]
                                                    //     .postFeeds[i1],
                                                    // id: feedProviderRepo.commentList[index].id,
                                                  )));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Stack(
                                        //     alignment: Alignment.center,
                                        //     children: <Widget>[
                                        //       SizedBox(
                                        //         width: 250,
                                        //         height: 150,
                                        //         child: Card(
                                        //             clipBehavior:
                                        //                 Clip.antiAlias,
                                        //             shape: RoundedRectangleBorder(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(20)),
                                        //             child: getsubCategoryRepos
                                        //                             .newFeedVar[
                                        //                                 index]
                                        //                             .postFeeds[
                                        //                                 i1]
                                        //                             .postPhoto
                                        //                             .length >
                                        //                         0 &&
                                        //                     getsubCategoryRepos
                                        //                             .newFeedVar[
                                        //                                 index]
                                        //                             .postFeeds[
                                        //                                 i1]
                                        //                             .postPhoto[
                                        //                                 0]
                                        //                             .location !=
                                        //                         null
                                        //                 ? CachedNetworkImage(
                                        //                     fit: BoxFit.cover,
                                        //                     imageUrl:
                                        //                         getsubCategoryRepos
                                        //                             .newFeedVar[
                                        //                                 index]
                                        //                             .postFeeds[
                                        //                                 i1]
                                        //                             .postPhoto[
                                        //                                 0]
                                        //                             .location)
                                        //                 : Container(
                                        //                     color: Colors.black,
                                        //                     width: 200,
                                        //                     child: Center(
                                        //                       child:
                                        //                           ReadMoreText(
                                        //                         '${getsubCategoryRepos.newFeedVar[index].postFeeds[i1].caption}',
                                        //                         colorClickableText:
                                        //                             Colors.pink,
                                        //                         textAlign:
                                        //                             TextAlign
                                        //                                 .start,
                                        //                         style: TextStyle(
                                        //                             fontSize:
                                        //                                 16,
                                        //                             color: Colors
                                        //                                 .white),
                                        //                       ),
                                        //                     ),
                                        //                   )),
                                        //       ),
                                        //       // Container(
                                        //       //     alignment: Alignment.center,
                                        //       //     child: getsubCategoryRepos
                                        //       //                     .newFeedVar[
                                        //       //                         index]
                                        //       //                     .postFeeds[i1]
                                        //       //                     .postPhoto
                                        //       //                     .length >
                                        //       //                 0 &&
                                        //       //             getsubCategoryRepos
                                        //       //                     .newFeedVar[
                                        //       //                         index]
                                        //       //                     .postFeeds[i1]
                                        //       //                     .postPhoto[0]
                                        //       //                     .location !=
                                        //       //                 null
                                        //       //         ? SizedBox(
                                        //       //             width: 200.0,
                                        //       //             child: ReadMoreText(
                                        //       //               '${getsubCategoryRepos.newFeedVar[index].postFeeds[i1].caption}',
                                        //       //               colorClickableText:
                                        //       //                   Colors.pink,
                                        //       //               textAlign:
                                        //       //                   TextAlign.start,
                                        //       //               style: TextStyle(
                                        //       //                   color: Colors
                                        //       //                       .white,
                                        //       //                   fontWeight:
                                        //       //                       FontWeight
                                        //       //                           .bold,
                                        //       //                   fontSize: 16.0),
                                        //       //             ),
                                        //       //           )
                                        //       //         : Container()),
                                        //     ]),

                                        Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 250,
                                                height: 150,
                                                child: Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: getsubCategoryRepos
                                                            .newFeedVar[index]
                                                            .postFeeds[i1]
                                                            .textFeed
                                                        ? Stack(
                                                            children: [
                                                              CachedNetworkImage(
                                                                height: 150,
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: getsubCategoryRepos
                                                                    .newFeedVar[
                                                                        index]
                                                                    .postFeeds[
                                                                        i1]
                                                                    .postPhoto[
                                                                        0]
                                                                    .location,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 5.0, left: 2),
                                                                child: Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.all(Radius.circular(25)),
                                                                      child: CachedNetworkImage(
                                                                          fit: BoxFit.fill,
                                                                          height: 42,
                                                                          width: 42,
                                                                          imageUrl: getImageUrl(getsubCategoryRepos.newFeedVar[index].postFeeds[i1].profilePic.location)),
                                                                    ),
                                                                    Container(
                                                                        padding: EdgeInsets.only(left: 5),
                                                                        child:   Text('@${getsubCategoryRepos.newFeedVar[index].postFeeds[i1].userName}',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold
                                                                          ),
                                                                        )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 45, top: 45),
                                                                // color: Colors.transparent.withOpacity(0.5),
                                                                width: double.infinity,
                                                                child: ReadMoreText(
                                                                    '${getsubCategoryRepos.newFeedVar[index].postFeeds[i1].caption}',
                                                                    colorClickableText:
                                                                  HexColor(
                                                                      "D41B47"),
                                                                    style: TextStyle(
                                                                  fontSize:
                                                                      14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight.bold),
                                                                  ),
                                                              ),
                                                            ],
                                                          )
                                                        : getsubCategoryRepos
                                                                    .newFeedVar[
                                                                        index]
                                                                    .postFeeds[
                                                                        i1]
                                                                    .postPhoto[
                                                                        0]
                                                                    .thumbnailUrl !=
                                                                null
                                                            ? Stack(
                                                                children: [
                                                                  CachedNetworkImage(
                                                                      width: 250,
                                                                      height: 150,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      imageUrl: getsubCategoryRepos
                                                                          .newFeedVar[
                                                                              index]
                                                                          .postFeeds[
                                                                              i1]
                                                                          .postPhoto[
                                                                              0]
                                                                          .thumbnailUrl),
                                                                  Positioned(
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          ClipOval(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                          HexColor(
                                                                              "D41B47"), // button color
                                                                          child: SizedBox(
                                                                              width: 46,
                                                                              height: 46,
                                                                              child: Icon(
                                                                                Icons.play_arrow,
                                                                                color: Colors.white,
                                                                                size: 30,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            :
                                                   Stack(
                                                     children: [
                                                       CachedNetworkImage(
                                                           width: 250,
                                                           height: 150,
                                                           fit: BoxFit.cover,
                                                           imageUrl: getsubCategoryRepos.newFeedVar[index].postFeeds[i1].postPhoto[0].location),
                                                       Positioned(
                                                           child: Column(

                                                               children: [

                                                                 Padding(
                                                                   padding: const EdgeInsets.only(top: 10.0),
                                                                   child: Row(
                                                                     children: [
                                                                       ClipRRect(
                                                                         borderRadius:
                                                                         BorderRadius.all(Radius.circular(25)),
                                                                         child: CachedNetworkImage(
                                                                             fit: BoxFit.fill,
                                                                             height: 42,
                                                                             width: 42,
                                                                             imageUrl: getImageUrl(getsubCategoryRepos.newFeedVar[index].postFeeds[i1].profilePic.location)),
                                                                       ),
                                                                       Container(
                                                                           padding: EdgeInsets.only(left: 5),

                                                                           child:   Text('@${getsubCategoryRepos.newFeedVar[index].postFeeds[i1].userName}',
                                                                             style: TextStyle(
                                                                               color: Colors
                                                                                   .white,
                                                                             ),
                                                                           )
                                                                       ),
                                                                     ],
                                                                   ),
                                                                 ),
                                                                 Container(
                                                                   alignment: Alignment.center,
                                                                   child: ClipOval(
                                                                     child: Material(
                                                                       color: HexColor(
                                                                           "D41B47"), // button color
                                                                       child: SizedBox(
                                                                           width: 46,
                                                                           height: 46,
                                                                           child: Icon(
                                                                             Icons.play_arrow,
                                                                             color: Colors.white,
                                                                             size: 30,
                                                                           )),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ]
                                                           )

                                                       )
                                                     ],
                                                   )
                                                ),
                                              ),
                                            ])
                                      ],
                                    ),
                                  );
                                },
                              ))
                        ],
                      );
                    }),
              ],
            ),
          ),
        );
      }),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: DiscoverySearchBarNew(
            categoryName: widget.categoryName,
          ),
        ),
      ),
    );
  }
}

class DiscoverySearchBarNew extends ConsumerWidget {
  final categoryName;

  DiscoverySearchBarNew({Key key, @required this.categoryName})
      : super(key: key);
  Widget build(BuildContext context, ScopedReader watch) {
    TextEditingController _Controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade900,
      ),
      height: 40,
      margin: EdgeInsets.only(
        left: 0,
        // right: 10,
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
            color: Colors.grey,
          ),
          hintText: 'Search $categoryName',
          contentPadding: EdgeInsets.only(bottom: 2, top: 4),
          hintStyle: TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
