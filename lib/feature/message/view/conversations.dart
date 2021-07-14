import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/message/models/chatlist.model.dart';
import 'package:farm_system/feature/message/models/conversationlist.model.dart';
import 'package:farm_system/feature/message/view/message.dart';
import 'package:farm_system/feature/message/view/userslist.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/services/socket.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

class ConversationList extends StatefulWidget {
  @override
  _State createState() => _State();
}

int toggle = 0;

class _State extends State<ConversationList>
    with SingleTickerProviderStateMixin {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  void initState() {
    getSocketReplies();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _generateUI(context)
        ],
      );
  }

  _generateUI(context) {
    return Consumer(builder: (context, watch, child) {
      final messageProviders = watch(messageProvider);
      return LazyLoadScrollView(
          onEndOfPage: () async {
            if (messageProviders.conversationList.length >10 && messageProviders.conversationList.length <
                messageProviders.conversationLength) {
              messageProviders.setPage(messageProviders.page + 1);
              await messageProviders.getConversations(messageProviders.page, "");
            }
          },
          child: Column(
            children: [
              messageProviders.searchClicked == false
                  ? Container(
                  color: Colors.black,
                  height: 99,
                  child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersList()),
                          );
                        },
                        child: Text("+ NEW MESSAGE",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              color: Colors.white,
                            )),
                      )
                    // SvgPicture.asset(logo_text_left)
                  ))
                  : Container(),
              Expanded(
                child:  Container(
                  color: Colors.black,
                  child: Center(
                    child: Consumer(builder: (context, watch, child) {
                      final messageProviders = watch(messageProvider);
                      return AsyncLoader(
                        key: _asyncKey,
                        initState: () => messageProviders.getConversations(messageProviders.page, ""),
                        renderLoad: () => CircularProgressIndicator(),
                        renderError: ([err]) => Text('There was a error'),
                        renderSuccess: ({data}) => _myListView(context),
                      );
                    }),
                  ),
                ),
              )
            ],
          )
      );
    });
  }



  Consumer _myListView(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final messageProviders = watch(messageProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);

      return  messageProviders.conversationList.length > 0
          ? ListView.builder(
        itemCount: messageProviders.conversationList.length,
        itemBuilder: (BuildContext context, int index) {
          return getCard(context, messageProviders.conversationList[index]);
        },
      ):Center(
        child: Text("No Data"),
      );
    });
  }

  @override
  Widget getCard(BuildContext context, Datum conversation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15, top: 15),
          child: InkWell(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListing(userId: conversation.userDetails.id,userName: conversation.userDetails.userName,conversationId: conversation.id,fromUsers: false,)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 30, right: 5),
                              child: CircleAvatar(
                                radius: 26.0,
                                backgroundImage: NetworkImage(getImageUrl(
                                    conversation.userDetails.userPic) ??
                                    "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                              )),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8, bottom: 2, left: 6),
                                    child: Text(
                                        conversation.userDetails.userName
                                            .toUpperCase(),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: Colors.pink,
                                        size: 24.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text(
                                            conversation.lastMessage
                                                .toUpperCase(),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 5),
                    child: Text(
                        getDateShortValues(conversation.createdAt)
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          width: MediaQuery.of(context).size.width * 0.74,
          height: 2,
          alignment: Alignment.topRight,
          color: Color.fromRGBO(255,255,255,0.1),
        )
      ],
    );
  }

  getSocketReplies(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userId = await StorageService.getUserId();
      SocketIO socketIO = SocketLibrary.getSocket();
      socketIO.subscribe('recentInboxConv', (data) {
        var wholeData = json.decode(data);
        print(wholeData);
        var found=false;
        var userDetails;
        for(var j=0;j<=wholeData['data'][0]['userDetails'].length;j++) {
          print(wholeData['data'][0]['userDetails'][j]['_id']);
          if(wholeData['data'][0]['userDetails'][j]['_id']!=userId){
            userDetails=wholeData['data'][0]['userDetails'][j];
            break;
          }
        }
        wholeData['data'][0]['userDetails']=userDetails;
        var conversations= context.read(messageProvider).conversationList;
        for(var i=0;i<=conversations.length;i++){
          if(conversations[i].id==wholeData['data'][0]['_id']){
            context.read(messageProvider).removeConversation(i);
            found=true;
            Datum temp =
            Datum.fromJson(wholeData['data'][0]);
            context.read(messageProvider).addReceivedConversation(temp);
            break;
          }
          if(conversations.length==i+1){
            break;
          }
        }
        if(found==false){
          Datum temp =
          Datum.fromJson(wholeData['data'][0]);
          context.read(messageProvider).addReceivedConversation(temp);
        }
      });
    });
  }
}