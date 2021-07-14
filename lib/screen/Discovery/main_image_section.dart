import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/view/feedLoaderShimmer.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainImageSection extends StatefulWidget {
  @override
  _MainImageSectionState createState() => _MainImageSectionState();
}

class _MainImageSectionState extends State<MainImageSection>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
          // ignore: missing_return
          builder: (context, watch, child) {
        final DiscoveryRepo = watch(discoveryProvider);
        return AsyncLoader(
            initState: () async => await DiscoveryRepo.getCategoryPost(),
            renderLoad: () => SizedBox(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => Container(
                child: DiscoveryRepo.discoveryList[0].content.length > 0 &&
                        DiscoveryRepo
                                .discoveryList[0].content[0].thumbnailurl !=
                            null
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: DiscoveryRepo.thumbnail),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: SvgPicture.asset(logo_text_left),
                        ),
                      )));
      }),
    );
  }
}
