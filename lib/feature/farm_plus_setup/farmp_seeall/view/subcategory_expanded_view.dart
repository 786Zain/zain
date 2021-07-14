import 'dart:ui';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class SubCategoryExpandedView extends ConsumerWidget {
  final categoryId;
  final subCategory;
  final categoryName;

  SubCategoryExpandedView({this.categoryId,this.subCategory,this.categoryName});



  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: non_constant_identifier_names
    final FarmPlusRepo = watch(farmPlusProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          padding: EdgeInsets.only(left: 80),
          child: Text('$categoryName'.toUpperCase(),
            style: TextStyle(color: Colors.grey,fontSize: 18),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: AsyncLoader(
        initState: () async => await FarmPlusRepo.farmSubCategory(categoryId,subCategory),
        renderLoad: () => AllElementShimmer(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) =>
            // GridView.builder(
            //   itemCount:FarmPlusRepo.subcategoryList.post[0].categoryContent.length,
            //   gridDelegate:
            //   SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //   itemBuilder: (BuildContext context, int index) {
            //     return GestureDetector(
            //       onTap: () {
            //        navigationToScreen(context, VideoExpandedPage(
            //          categoryName: categoryName,
            //          imageurl: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].thumbnailUrl,
            //          title: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].title,
            //          bodyText: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].bodyText,
            //          filepath: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].videoUrl,
            //        ), false);
            //       },
            //       child: SizedBox(
            //         width: 250,
            //         height: 160,
            //         child: Card(
            //           clipBehavior: Clip.antiAlias,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(20)),
            //           child: Container(
            //             width: 250,
            //             height: 180,
            //             child:
            //             CachedNetworkImage(
            //                 fit: BoxFit.cover,
            //                 imageUrl: getImageUrl(FarmPlusRepo.subcategoryList.post[0].categoryContent[index].thumbnailUrl)),
            //           ),
            //         ),
            //       ),
            //     );// here
            //   },
            // ),
        GridView.count(
    crossAxisCount: 2,
    childAspectRatio: (1 / .6),
    shrinkWrap: true,
    children: List.generate(FarmPlusRepo.subcategoryList.post[0].categoryContent.length, (index) {

    return GestureDetector(
          onTap: () {
           navigationToScreen(context, VideoExpandedPage(
             categoryName: categoryName,
             imageurl: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].thumbnailUrl,
             title: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].title,
             bodyText: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].bodyText,
             filepath: FarmPlusRepo.subcategoryList.post[0].categoryContent[index].videoUrl,
           ), false);
          },
          child: SizedBox(
            width: 250,
            height: 160,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 250,
                height: 180,
                child:
                CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: getImageUrl(FarmPlusRepo.subcategoryList.post[0].categoryContent[index].thumbnailUrl)),
              ),
            ),
          ),
        );// here

      }),
      ),
      )
    );
  }
}
