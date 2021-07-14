import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_setup/view/video_expanded/video_expanded.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FarmPlusImageSection extends StatefulWidget {
  @override
  _FarmPlusImageSectionState createState() => _FarmPlusImageSectionState();
}

class _FarmPlusImageSectionState extends State<FarmPlusImageSection>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child:Image.asset(farm_plus_logo)
      //SvgPicture.asset(logo_text_left),
    );
    // Container(
    //   child: Consumer(
    //     // ignore: missing_return
    //       builder: (context, watch, child) {
    //         // ignore: non_constant_identifier_names
    //         final FarmPlusRepo = watch(farmPlusProvider);
    //         return
    //           AsyncLoader(
    //           initState: () async => await FarmPlusRepo.farmCategoryPost(),
    //           renderLoad: () => MainImageShimmer(),
    //           renderError: ([err]) => Text('There was a error'),
    //           renderSuccess: ({data}) =>
    //               Container(
    //                 child: FarmPlusRepo.farmplusList[0].content.length > 0 &&
    //                     FarmPlusRepo.farmplusList[0].content[0].thumbnailurl != null
    //                     ? GestureDetector(
    //                   onTap: (){
    //                     navigationToScreen(context, VideoExpandedPage(
    //                       imageurl: FarmPlusRepo.farmplusList[0].content[0].thumbnailurl,
    //                       title: FarmPlusRepo.farmplusList[0].content[0].title,
    //                       bodyText: FarmPlusRepo.farmplusList[0].content[0].bodyText,
    //                       categoryName: FarmPlusRepo.farmplusList[0].content[0].categoryName,
    //                     ), false);
    //                   },
    //                   child: CachedNetworkImage(
    //                     fit: BoxFit.fill, imageUrl: FarmPlusRepo.farmplusList[0].content[0].thumbnailurl,
    //                   ),
    //                 ): SvgPicture.asset(logo_text_left),
    //               ),
    //         );
    //       }),
    // );
  }
}
