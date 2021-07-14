import 'dart:convert';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/view/readmoretext.dart';
import 'package:farm_system/feature/first_screen/repo/NotificationModel.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:farm_system/services/socket.dart';
import 'package:farm_system/storage.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FirstScreen extends StatefulWidget {
  bool farmPlusAppBar;

  FirstScreen({this.farmPlusAppBar});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _asyncfollowerKey = GlobalKey<AsyncLoaderState>();
  void initState() {
    getSocketNotification();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getNotificationList(context);
  }

  Widget getNotificationList(context) {
    return Container(
      color: Colors.black,
      child: Consumer(builder: (context, watch, child) {
        final feedProviderRepo = watch(feedProvider);
        final notificationLists = watch(notificationList);
        return AsyncLoader(
          key: _asyncfollowerKey,
          // ignore: missing_return
          initState: () async {
            //feedProviderRepo.setCounterEmpty();
            await notificationLists.getNotifications();
            feedProviderRepo.setNotificationCount(0);
          },
          renderLoad: () => SizedBox(),
          renderError: ([err]) => Text('There was a error'),
          renderSuccess: ({data}) => _generateNotificationsUI(context),
        );
      }),
    );
  }

  _generateNotificationsUI(context) {
    return Consumer(builder: (context, watch, child) {
      final notificationsLists = watch(notificationList);
      // final feedRepo = watch(feedProvider);
      // feedRepo.setNotificationCount(0);
      return notificationsLists.notificationList.length > 0
          ? ListView.builder(
              itemCount: notificationsLists.notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                var dt = new DateTime.now();
                var days = dt
                    .difference(
                        notificationsLists.notificationList[index].createdAt)
                    .inDays;
                return GestureDetector(
                    onTap: () async {
                      await notificationsLists.callApiBasedOnType(
                          context,
                          notificationsLists
                              .notificationList[index].activityType,
                          notificationsLists
                              .notificationList[index].referenceId);
                    },
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.white,
                          height: 0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  child: notificationsLists
                                              .notificationList[index]
                                              .profilePic ==
                                          null
                                      ? Image.asset(dummyUser,
                                          fit: BoxFit.fill,
                                          height: 52,
                                          width: 52)
                                      : InkWell(
                                          child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              height: 52,
                                              width: 52,
                                              imageUrl: getImageUrl(
                                                  notificationsLists
                                                      .notificationList[index]
                                                      .profilePic)),
                                          onTap: () {
                                            navigationToScreen(
                                                context,
                                                ProfileTab(
                                                    userId: notificationsLists
                                                        .notificationList[index]
                                                        .guestId),
                                                false);
                                          },
                                        ),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          child: Container(
                                            child: notificationsLists
                                                            .notificationList[
                                                                index]
                                                            .name !=
                                                        "" &&
                                                    notificationsLists
                                                            .notificationList[
                                                                index]
                                                            .name !=
                                                        null
                                                ? Text(
                                                    Utils.getCapitalizeName(
                                                        '${notificationsLists.notificationList[index].name}'),
                                                    style: GoogleFonts.openSans(
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontSize: 15.0,
                                                    ),
                                                  )
                                                : Text(" "),
                                          ),
                                          onTap: () {
                                            navigationToScreen(
                                                context,
                                                ProfileTab(
                                                    userId: notificationsLists
                                                        .notificationList[index]
                                                        .guestId),
                                                false);
                                          },
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        InkWell(
                                          child: Container(
                                            child: notificationsLists
                                                            .notificationList[
                                                                index]
                                                            .userName !=
                                                        "" &&
                                                    notificationsLists
                                                            .notificationList[
                                                                index]
                                                            .userName !=
                                                        null
                                                ? Text(
                                                    '@${notificationsLists.notificationList[index].userName}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0xff666666)))
                                                : Text(" "),
                                          ),
                                          onTap: () {
                                            navigationToScreen(
                                                context,
                                                ProfileTab(
                                                    userId: notificationsLists
                                                        .notificationList[index]
                                                        .guestId),
                                                false);
                                          },
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 0, left: 5),
                                              child: days < 7
                                                  ? Text(
                                                  getTime(notificationsLists.notificationList[index]
                                                      .createdAt),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color:Colors.white
                                                      // Color(0xff888888)
                                                  ))
                                                  : Text(DateFormat('dd-MMM')
                                                      .format(notificationsLists
                                                          .notificationList[
                                                              index]
                                                          .createdAt))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    child: Visibility(
                                      visible: notificationsLists
                                              .notificationList[index].text !=
                                          null,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                            notificationsLists
                                                    .notificationList[index]
                                                    .text ??
                                                '',
                                            colorClickableText: Colors.grey,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff666666),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ));
              },
            )
          : Container(
              child: Center(
                child: Text(
                  "No Notifications",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
    });
  }

  getSocketNotification() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userId = await StorageService.getUserId();
      SocketIO socketIO = SocketLibrary.getSocket();
      socketIO.subscribe('recentNotifications', (data) {
        var wholeData = json.decode(data);
        Datum temp = Datum.fromJson(wholeData['data'][0]);
        context.read(notificationList).getList(temp);
        //context.read(notificationList).isNotSeenCount;
      });
    });
  }
}
