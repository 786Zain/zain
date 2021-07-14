import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/all_expanded_view.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/farm_seeall.dart';
import 'package:farm_system/feature/farm_plus_setup/repo/farm_plus_repo.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ImagesListView extends StatefulWidget {
  @override
  _ImagesListView createState() => _ImagesListView();
}

class _ImagesListView extends State<ImagesListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, watch, child) {
      final FarmPlusRepo = watch(farmPlusProvider);
      return AsyncLoader(
          initState: () async => await FarmPlusRepo.farmCategoryPost(),
          renderLoad: () => AllElementShimmer(),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: FarmPlusRepo.farmplusList[0].post.length,
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
                              FarmPlusRepo
                                  .farmplusList[0].post[index].categoryName,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  var categoryId = FarmPlusRepo
                                      .farmplusList[0].post[index].categoryId;
                                  print('hgavdhvshvhsvdhs');
                                  print(categoryId);
                                  var categoryName = FarmPlusRepo
                                      .farmplusList[0].post[index].categoryName;
                                  FarmPlusRepo.farmplusList[0].post[index]
                                              .categoryName ==
                                          'Farm Drills'
                                      ? navigationToScreen(
                                          context,
                                          FarmSeeAllPage(
                                            subCategory: FarmPlusRepo
                                                .farmplusList[0]
                                                .post[0]
                                                .categoryContent[index]
                                                .subCategory,
                                            categoryId: categoryId,
                                            categoryName: categoryName,
                                          ),
                                          false)
                                      : navigationToScreen(
                                          context,
                                          FarmPlusExpandedView(
                                            categoryName: categoryName,
                                            categoryId: categoryId,
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
                          itemCount: FarmPlusRepo.farmplusList[0].post[index]
                              .categoryContent.length,
                          itemBuilder: (BuildContext context, int i1) {
                            return GestureDetector(
                              onTap: () {
                                navigationToScreen(
                                    context,
                                    VideoExpandedPage(
                                      categoryName: FarmPlusRepo.farmplusList[0]
                                          .post[index].categoryName,
                                      bodyText: FarmPlusRepo
                                          .farmplusList[0]
                                          .post[index]
                                          .categoryContent[i1]
                                          .bodyText,
                                      imageurl: FarmPlusRepo
                                          .farmplusList[0]
                                          .post[index]
                                          .categoryContent[i1]
                                          .thumbnailUrl,
                                      title: FarmPlusRepo
                                          .farmplusList[0]
                                          .post[index]
                                          .categoryContent[i1]
                                          .title,
                                      filepath: FarmPlusRepo
                                          .farmplusList[0]
                                          .post[index]
                                          .categoryContent[i1]
                                          .videoUrl,
                                    ),
                                    false);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    height: 150,
                                    child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: FarmPlusRepo
                                                    .farmplusList[0]
                                                    .post[index]
                                                    .categoryContent[i1]
                                                    .thumbnailUrl !=
                                                null
                                            ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: getImageUrl(
                                                    FarmPlusRepo
                                                        .farmplusList[0]
                                                        .post[index]
                                                        .categoryContent[i1]
                                                        .thumbnailUrl))
                                            : Container(
                                                color: Colors.black,
                                                child: Center(
                                                  child: Text(
                                                    'No image in the particular post',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )),
                                  )
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                );
              }));
    });
  }
}
