import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/models/sub_category_models.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hexcolor/hexcolor.dart';

import 'View/see_all.dart';

class ExpandedView extends ConsumerWidget {
  final categoryName;
  final subcategoryName;
  Feed dataForpage;

  ExpandedView(
      {Key key,
      @required this.categoryName,
      @required this.subcategoryName,
      @required this.dataForpage})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: non_constant_identifier_names
    final DiscoveryRepo = watch(discoveryProvider);
    return Scaffold(
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
        title: Center(
          child: Text(
            '$categoryName - $subcategoryName',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      body:
        GridView.count(
    crossAxisCount: 2,
    childAspectRatio: (1 / .6),
    shrinkWrap: true,
    children: List.generate(dataForpage.postFeeds.length, (index) {

      // GridView.builder(
      //
      //   itemCount: dataForpage.postFeeds.length,
      //   gridDelegate:
      //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //   itemBuilder: (BuildContext context, int index) {

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPost(
                            isFromDiscover: true,
                            id: dataForpage.postFeeds[index].id,
                            hideImage: dataForpage.postFeeds[index].textFeed,
                          )));
            },
            child: SizedBox(
              width: 350,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  // shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),

                child: dataForpage.postFeeds[index].postPhoto.length > 0 &&
                        dataForpage.postFeeds[index].postPhoto[0].location !=
                            null
                    ?
                    // Stack(alignment: Alignment.center, children: [
                    //         Container(
                    //           width: 250,
                    //           height: 210,
                    //           child: CachedNetworkImage(
                    //               fit: BoxFit.cover,
                    //               imageUrl: dataForpage.postFeeds[index].postPhoto[0].location),
                    //         ),
                    //         // Container(
                    //         //     alignment: Alignment.center,
                    //         //     margin: EdgeInsets.all(10),
                    //         //     child: SizedBox(
                    //         //       width: 180.0,
                    //         //       child: ReadMoreText(
                    //         //         '${dataForpage.postFeeds[index].caption}',
                    //         //         colorClickableText: Colors.pink,
                    //         //         textAlign: TextAlign.start,
                    //         //         style: TextStyle(
                    //         //             color: Colors.white,
                    //         //             fontWeight: FontWeight.bold,
                    //         //             fontSize: 16.0),
                    //         //       ),
                    //         //     )),
                    //       ])
                    Stack(alignment: Alignment.center, children: <Widget>[
                        SizedBox(
                          width: 350,
                          height: 120,
                          child: Card(
                            shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.antiAlias,
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20)),
                              child: dataForpage.postFeeds[index].textFeed
                                  ? Stack(
                                      children: [
                                        CachedNetworkImage(
                                          width: 250,
                                          height: 150,
                                          // width: double.infinity,
                                          fit: BoxFit.cover,
                                          imageUrl: dataForpage.postFeeds[index]
                                              .postPhoto[0].location,
                                        ),
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
                                                    imageUrl: getImageUrl(dataForpage.postFeeds[index].profilePic.location)),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(left: 5),

                                                  child:   Text('@${dataForpage.postFeeds[index].userName}',
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
                                          padding: EdgeInsets.only(left: 2),
                                          // color: Colors.transparent
                                          //     .withOpacity(0.5),
                                          width: double.infinity,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 45, top: 45),
                                            child: ReadMoreText(
                                              '${dataForpage.postFeeds[index].caption}',
                                              colorClickableText:
                                                  HexColor("D41B47"),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : dataForpage.postFeeds[index].postPhoto[0]
                                              .thumbnailUrl !=
                                          null
                                      ? Stack(
                                          children: [
                                            CachedNetworkImage(
                                                width: 350,
                                                height: 150,
                                                fit: BoxFit.cover,
                                                imageUrl: dataForpage
                                                    .postFeeds[index]
                                                    .postPhoto[0]
                                                    .thumbnailUrl),
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
                                                        imageUrl: getImageUrl(dataForpage.postFeeds[index].profilePic.location)),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(left: 5),

                                                      child:   Text('@${dataForpage.postFeeds[index].userName}',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              child: Container(
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
                                          imageUrl: dataForpage.postFeeds[index]
                                              .postPhoto[0].location),
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
                                                            imageUrl: getImageUrl(dataForpage.postFeeds[index].profilePic.location)),
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(left: 5),

                                                          child:   Text('@${dataForpage.postFeeds[index].userName}',
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
                    : Container(
                        alignment: Alignment.center,
                        color: Colors.black,
                        width: 350.0,
                        child: ReadMoreText(
                          '${dataForpage.postFeeds[index].caption}',
                          colorClickableText: Colors.pink,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
        )
    );
  }
}
