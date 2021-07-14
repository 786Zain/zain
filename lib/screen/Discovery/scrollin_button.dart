import 'package:async_loader/async_loader.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/see_all.dart';
import 'package:farm_system/screen/Discovery/discovery_model.dart';
import 'package:farm_system/screen/Discovery/repo/discovery.repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shimmer/shimmer.dart';

import 'all_element.dart';

class ScrollingButton extends StatefulWidget {
  @override
  _ScrollingButtonState createState() => _ScrollingButtonState();
}

class _ScrollingButtonState extends State<ScrollingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        // ignore: missing_return
        builder: (context, watch, child) {
          // ignore: non_constant_identifier_names
          final DiscoveryRepo = watch(discoveryProvider);
          // int index;
          return AsyncLoader(
            initState: () => DiscoveryRepo.getCategoryPost(),
            renderLoad: () => SizedBox(),
            renderError: ([err]) => Text('There was a error'),
            renderSuccess: ({data}) => uiForButton(data, DiscoveryRepo),
          );
        },
      ),
    );
  }

  uiForButton(CategoryList data, DiscoveryRepo discoveryRepo) {
    return Consumer(
      builder: (context, watch, child) {
        // ignore: non_constant_identifier_names
        final DiscoveryRepo = watch(discoveryProvider);
        return Container(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: DiscoveryRepo.discoveryList[0].categoryList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RaisedButton(
                          onPressed: () {
                            print(DiscoveryRepo
                                .discoveryList[0].categoryList[index].id);
                            navigationToScreen(
                                context,
                                SeeAllPost(
                                  categoryId: DiscoveryRepo
                                      .discoveryList[0].categoryList[index].id,
                                  categoryName: DiscoveryRepo.discoveryList[0]
                                      .categoryList[index].categoryName,
                                ),
                                false);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey)),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DiscoveryRepo.discoveryList[0].categoryList[index]
                                  .categoryName,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
