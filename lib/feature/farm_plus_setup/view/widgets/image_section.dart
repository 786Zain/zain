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

class ImageSection extends StatefulWidget {
  @override
  _ImageSectionState createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(builder: (context, watch, child) {
        final FarmPlusRepo = watch(farmPlusProvider);
        return AsyncLoader(
            initState: () async => await FarmPlusRepo.farmCategoryPost(),
            renderLoad: () => MainImageShimmer(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => Container(
                child: FarmPlusRepo.farmplusList[0].content.length > 0 &&
                        FarmPlusRepo.farmplusList[0].content[0].thumbnailurl !=
                            null
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: GestureDetector(
                            onTap: () {
                              navigationToScreen(
                                  context,
                                  VideoExpandedPage(
                                    imageurl: FarmPlusRepo.farmplusList[0]
                                        .content[0].thumbnailurl,
                                    title: FarmPlusRepo
                                        .farmplusList[0].content[0].title,
                                    bodyText: FarmPlusRepo
                                        .farmplusList[0].content[0].bodyText,
                                    categoryName: FarmPlusRepo.farmplusList[0]
                                        .content[0].categoryName,
                                    filepath: FarmPlusRepo
                                        .farmplusList[0].content[0].videoUrl,
                                  ),
                                  false);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: FarmPlusRepo
                                  .farmplusList[0].content[0].thumbnailurl,
                              //     ),),
                            ),
                          ),
                        ))
                    : Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(farm_plus_logo),
                        ),
                      )));
      }),
    );
     }
}
