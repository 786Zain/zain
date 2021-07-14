import 'package:async_loader/async_loader.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/all_expanded_view.dart';
import 'package:farm_system/feature/farm_plus_setup/farmp_seeall/view/farm_seeall.dart';
import 'package:farm_system/feature/farm_plus_setup/farm_plus_model/farm_plus_model.dart';
import 'package:farm_system/feature/farm_plus_setup/repo/farm_plus_repo.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/SeeAll/View/mainElementShimmer.dart';
import 'package:farm_system/screen/Discovery/SeeAll/allElementShimmer.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';

class OptionsButton extends StatefulWidget {
  @override
  _OptionsButtonState createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  final categoryId;

  _OptionsButtonState({this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer(
        // ignore: missing_return
        builder: (context, watch, child) {
      // ignore: non_constant_identifier_names
      final FarmPlusRepo = watch(farmPlusProvider);
      return AsyncLoader(
        initState: () async => await FarmPlusRepo.farmCategoryPost(),
        renderLoad: () => AllElementShimmer(),
        renderError: ([err]) => Text('There was a error'),
        renderSuccess: ({data}) =>
            categoryButton(data, FarmPlusRepo,),
      );
    }));
  }

  categoryButton(Data data, FarmPlusRepo farmPlusRepo,) {
    return Consumer(
      builder: (context, watch, child) {
        // ignore: non_constant_identifier_names
        final FarmPlusRepo = watch(farmPlusProvider);
        return Container(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: FarmPlusRepo.farmplusList[0].categoryList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RaisedButton(
                          onPressed: () {
                           var categoryId = FarmPlusRepo.farmplusList[0].categoryList[index].id;
                            print('hgavdhvshvhsvdhs');
                            print(categoryId);
                            var categoryName = FarmPlusRepo.farmplusList[0]
                                .categoryList[index].categoryName;
                            FarmPlusRepo.farmplusList[0].categoryList[index]
                                        .categoryName ==
                                    FarmPlusRepo.farmplusList[0].categoryList[2]
                                        .categoryName
                                ? navigationToScreen(
                                    context,
                                    FarmSeeAllPage(
                                      subCategory: FarmPlusRepo.farmplusList[0].post[0].categoryContent[index].subCategory,
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.black,
                          child: Text(
                            FarmPlusRepo.farmplusList[0].categoryList[index]
                                .categoryName,
                            style: TextStyle(color: Colors.white),
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
