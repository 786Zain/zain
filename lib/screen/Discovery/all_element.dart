import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/dashboard/deatailsPost.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/see_all.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AllElementListView extends StatefulWidget {
  @override
  _AllElementListViewState createState() => _AllElementListViewState();
}

class _AllElementListViewState extends State<AllElementListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      // ignore: missing_return
      builder: (context, watch, child) {
        // ignore: non_constant_identifier_names
        final DiscoveryRepo = watch(discoveryProvider);
        final feedProviderRepo = watch(feedProvider);
        final subCategoryDisccoveryRepo = watch(subCategoryProvider);
        return AsyncLoader(
          initState: () => DiscoveryRepo.getCategoryPost(),
          renderLoad: () => Center(child: CircularProgressIndicator()),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: DiscoveryRepo.discoveryList[0].posts.length,
                itemBuilder: (BuildContext context, int index) {
                  print(DiscoveryRepo.postVar[index].feeds[0].id);
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
                                DiscoveryRepo.postVar[index].categoryName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    var categorIds =
                                        DiscoveryRepo.postVar[index].categoryId;
                                    var categoryName = DiscoveryRepo
                                        .postVar[index].categoryName;
                                    navigationToScreen(
                                        context,
                                        SeeAllPost(
                                          categoryId: categorIds,
                                          categoryName: categoryName,
                                        ),
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
                            itemCount:
                                DiscoveryRepo.postVar[index].feeds.length,
                            itemBuilder: (BuildContext context, int i1) {
                              return GestureDetector(
                                onTap: () {
                                  print(DiscoveryRepo
                                      .postVar[index].feeds[i1].id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsPost(
                                                hideImage: false,
                                                isFromDiscover: true,
                                                id: DiscoveryRepo.postVar[index].feeds[i1].id,
                                                //discoveryDetail: DiscoveryRepo.postVar[index].feeds[i1],
                                              )));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 250,
                                            height: 150,
                                            child: DiscoveryRepo
                                                .postVar[
                                            index]
                                                .feeds[i1]
                                                .postPhoto.isNotEmpty ?
                                            Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: DiscoveryRepo
                                                        .postVar[index]
                                                        .feeds[i1]
                                                        .textFeed
                                                    ? Stack(
                                                        children: [
                                                          CachedNetworkImage(
                                                            height: 150,
                                                            width: double.infinity,
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                DiscoveryRepo
                                                                    .postVar[
                                                                        index]
                                                                    .feeds[i1]
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
                                                                     imageUrl: getImageUrl(DiscoveryRepo.postVar[index].feeds[i1].profilePic.location)),
                                                               ),
                                                               Container(
                                                                   padding: EdgeInsets.only(left: 5),
                                                                   child:   Text('@${DiscoveryRepo.postVar[index].feeds[i1].userName}',
                                                                     style: TextStyle(
                                                                       color: Colors.white,
                                                                         fontWeight: FontWeight.bold
                                                                     ),
                                                                   )
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                          InkWell(
                                                            onTap: (){
                                                              print('ontap of text');
                                                              print(DiscoveryRepo
                                                                  .postVar[index].feeds[i1].id);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DetailsPost(
                                                                        hideImage: true,
                                                                        isFromDiscover: true,
                                                                        id: DiscoveryRepo.postVar[index].feeds[i1].id,
                                                                        discoveryDetail: DiscoveryRepo.postVar[index].feeds[i1],
                                                                        discoveryother: DiscoveryRepo.postVar[index],
                                                                      )));
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(left: 45, top: 45),
                                                              // color: Colors.transparent.withOpacity(0.5),
                                                              width: double.infinity,
                                                              child: ReadMoreText(
                                                                  '${DiscoveryRepo.postVar[index].feeds[i1].caption}',
                                                                  colorClickableText:
                                                                HexColor(
                                                                    "D41B47"),
                                                                  style: TextStyle(
                                                                fontSize:
                                                                    14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    :
                                                DiscoveryRepo.postVar[index].feeds[i1].postPhoto[0].thumbnailUrl != null ?
                                                Stack(
                                                  children: [
                                                    CachedNetworkImage(
                                                      width: 250,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                        imageUrl:  DiscoveryRepo
                                                            .postVar[index]
                                                            .feeds[i1]
                                                            .postPhoto[0]
                                                            .thumbnailUrl),
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
                                                                        imageUrl: getImageUrl(DiscoveryRepo.postVar[index].feeds[i1].profilePic.location)),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(left: 5),

                                                                      child:   Text('@${DiscoveryRepo.postVar[index].feeds[i1].userName}',
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
                                                :

                                                Stack(
                                                  children: [
                                                    CachedNetworkImage(
                                                        width: 250,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                        imageUrl: DiscoveryRepo
                                                            .postVar[index]
                                                            .feeds[i1]
                                                            .postPhoto[0]
                                                            .location),
                                                Positioned(
                                                  child: Padding(
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
                                                              imageUrl: getImageUrl(DiscoveryRepo.postVar[index].feeds[i1].profilePic.location)),
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.only(left: 5),

                                                            child:   Text('@${DiscoveryRepo.postVar[index].feeds[i1].userName}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                  ],
                                                )

                                            ) : Container()
                                          ),
                                        ])
                                  ],
                                )
                              );
                            },
                          ))
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}

Future<Object> navigationToScreen(
    BuildContext context, Widget screen, bool navbar) {
  return pushNewScreen(context,
      screen: screen,
      withNavBar: navbar,
      pageTransitionAnimation: PageTransitionAnimation.fade);
}
