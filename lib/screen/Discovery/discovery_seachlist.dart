// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/profile_user/view/profile_info.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farm_system/utils.dart';
// ignore: must_be_immutable
class DiscoverySearchUi extends ConsumerWidget {
  final _controller = TextEditingController();
  String searchKey;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: non_constant_identifier_names
    final DiscoverySearchRepo = watch(discoverySearchprovider);
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.grey[900],
            brightness: Brightness.dark,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    DiscoverySearchRepo.searchList.clear();
                  },
                  padding: EdgeInsets.only(top: 7),
                  icon: Icon(Icons.arrow_back_ios,
                      color: Color.fromRGBO(145, 145, 145, 100),
                      size: 25
                  )),
            ),
            title: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800]
              ),
              height: 40,
              width: 400,
              margin: EdgeInsets.only(
                left: 0,
                right: 5,
                top: 6,
              ),
              child: TextFormField(
                controller: _controller,
                showCursor: true,
                cursorColor: Colors.white,
                onChanged: (T) {
                  DiscoverySearchRepo.getSearchList(T);
                },
                autofocus: true,
                enableSuggestions: false,
                autocorrect: false,
                style:
                GoogleFonts.montserrat(
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(145, 145, 145, 100),
                    ),
                    hintText: 'Search the farm',
                    contentPadding: EdgeInsets.only(bottom: 2, top: 4),
                    hintStyle:       GoogleFonts.montserrat(
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600])
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DiscoverySearchRepo.searchList.isNotEmpty
                  ?
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: DiscoverySearchRepo.searchList.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                DiscoverySearchRepo.searchList[i].profilePic != null ?
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          DiscoverySearchRepo
                                              .searchList[i].profilePic),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0)),
                                  ),
                                ):
                                Container(
                                  child: Image.asset(dummyUser,
                                      fit: BoxFit.fill, height: 52, width: 52),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                InkWell(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: DiscoverySearchRepo
                                            .searchList[i]
                                            .name !=
                                            null
                                            ?
                                        Text(
                                          DiscoverySearchRepo
                                              .searchList[i]
                                              .name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[600]
                                          ),
                                        )
                                            : Text(" "),
                                      ),
                                      Container(
                                        child: DiscoverySearchRepo
                                            .searchList[i].userName !=
                                            null
                                            ? Text(
                                          '@' +
                                              DiscoverySearchRepo
                                                  .searchList[i]
                                                  .userName,
                                          style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[600]
                                          ),
                                        )
                                            : Text(""),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    navigationToScreen(
                                        context,
                                        ProfileTab(
                                            userId: DiscoverySearchRepo
                                                .searchList[i].id),
                                        false);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              )
                  : Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                ),
                child: Center(
                  child: Text(
                    'No Search History Found',
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

