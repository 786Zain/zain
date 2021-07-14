import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_system/camera/video.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/farm_post/custom_gallery.dart';
import 'package:farm_system/feature/message/models/chatlist.model.dart';
import 'package:farm_system/feature/message/view/conversations.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/services/socket.dart';
import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:farm_system/feature/message/repo/message.repo.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class MessageListing extends StatefulWidget {
  final userId;
  final conversationId;
  final userName;
  final fromUsers;
  final File file;

  const MessageListing(
      {Key key,
      this.userId,
      this.conversationId,
      this.userName,
      this.fromUsers,
      this.file})
      : super(key: key);
  @override
  _MessageListingState createState() => _MessageListingState();
}

class _MessageListingState extends State<MessageListing>
    with TickerProviderStateMixin {
  final _asyncKey = GlobalKey<AsyncLoaderState>();
  int page = 1;
  final TextEditingController _controller = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  AnimationController _con;
  Timer _debounce;
  int toggle = 0;
  var _conversationId;
  static SocketIO socketIO;
  String manageConversationString;
  bool deleteStatus = false;
  List _messageList = [];
  bool _selectAll = false;
  bool deleteClicked = false;
  @override
  void initState() {
    deleteClicked = false;
    _conversationId = widget.conversationId;
    getConversation();
    if (widget.file != null) {
      submitMessage();
    }

    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
    listScrollController.addListener(_scrollListener);
    if (widget.fromUsers == true) {}
    getSocketReplies();
    _messageList = [];
    // TODO: implement initState
    super.initState();
  }

  getConversation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.conversationId == "") {
        Map<String, dynamic> map = Map<String, dynamic>();
        map['receiverId'] = widget.userId;
        _conversationId =
            await context.read(messageProvider).getConversationId(map);
      } else {
        await context
            .read(messageProvider)
            .setConversationId(widget.conversationId);
      }
    });
  }

  _showPopupMenu() async {
    double left = MediaQuery.of(context).size.width - 50;
    double top = 40;
    bool type = await context.read(messageProvider).notificationType;
    manageConversationString = await showMenu(
      context: context,
      color: Color.fromRGBO(55, 52, 52, 1),
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
            height: 30,
            child: Container(
                width: 180,
                child: const Text('Delete Messages',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
            value: 'delete'),
        PopupMenuItem<String>(
            height: 30,
            child: Container(
                width: 180,
                child: Text(
                    (type == false)
                        ? 'Turn On Notifications'
                        : 'Turn Off Notifications',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
            value: 'notification'),
      ],
      elevation: 8.0,
    );
    optionClicked(manageConversationString, type);
  }

  optionClicked(String type, boolType) {
    switch (type) {
      case "notification":
        setNotification(boolType);
        break;
      case "delete":
        deleteMessages();
        break;
    }
  }

  setNotification(boolType) async {
    await context.read(messageProvider).manageNotification(boolType);
  }

  deleteMessages() {
    setState(() {
      deleteStatus = !deleteStatus;
    });
  }

  getSocketReplies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userId = await StorageService.getUserId();
      SocketIO socketIO = SocketLibrary.getSocket();
      socketIO.subscribe('recentMessage', (data) {
        print('gsdgsvdgvshdhsd');
        var wholeData = json.decode(data);
        if (widget.conversationId == wholeData['data'][0]['conversationId']) {
          if (userId != wholeData['data'][0]['createdBy']) {
            wholeData['data'][0]['IAMsender'] = false;
            Chat temp = Chat.fromJson(wholeData['data'][0]);
            context.read(messageProvider).addReceivedMessage(temp);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Container(
                child: Center(
                    child: Text(
              widget.userName != null
                  ? deleteStatus == false
                      ? widget.userName.toUpperCase()
                      : "SELECT MESSAGES"
                  : "",
              style:  GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: Colors.white)
            ))),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                color: Color(0xffFFFFFF),
                iconSize: 20,
                onPressed: () {
                  if (widget.file != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    );
                  } else {
                    if (deleteStatus == false) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _messageList = [];
                        deleteStatus = false;
                      });
                    }
                  }
                }),
            actions: [
              Consumer(builder: (context, watch, child) {
                final messageProviders = watch(messageProvider);
                return messageProviders.chatlist.length != 0
                    ? deleteStatus == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Text("ALL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 2,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    if (_messageList.length ==
                                        context
                                            .read(messageProvider)
                                            .chatLength) {
                                      setState(() {
                                        _selectAll = false;
                                        _messageList = [];
                                      });
                                    } else {
                                      selectAll();
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: (_messageList.length ==
                                              messageProviders.chatlist.length)
                                          ? Color.fromRGBO(212, 27, 71, 1)
                                          : Colors.black,
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(212, 27, 71, 1)),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 22.0,
                                    width: 23.0,
                                    child: Center(
                                        // Your Widget
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              _showPopupMenu();
                            },
                            icon: new Icon(Icons.more_horiz,
                                color: Color(0xffFFFFFF)),
                          )
                    : Container();
              })
            ],
          ),
        ),
        body: Consumer(builder: (context, watch, child) {
          final messageProviders = watch(messageProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AsyncLoader(
                key: _asyncKey,
                initState: () => messageProviders.getChats(
                    1, widget.conversationId, widget.userId),
                renderLoad: () => CircularProgressIndicator(),
                renderError: ([err]) => Text('Error'),
                renderSuccess: ({data}) => _generateUI(),
              ),
              _textComposerWidget()
            ],
          );
        }));
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() async {
        page = page + 1;
        if (context.read(messageProvider).chatLength >
            context.read(messageProvider).chatlist.length) {
          await context
              .read(messageProvider)
              .getChats(page, widget.conversationId, widget.userId);
          if (_selectAll == true) {
            selectAll();
          }
        }
      });
    }
  }

  _generateUI() {
    return Container(
      child: Consumer(builder: (context, watch, child) {
        final messageProviders = watch(messageProvider);
        return messageProviders.chatlist.length > 0
            ? Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    controller: listScrollController,
                    itemCount: messageProviders.chatlist.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return messageWidget(messageProviders, index);
                    },
                  ),
                ),
              )
            : Container();
      }),
    );
  }

  Widget messageWidget(messageProviders, index) {
    return Container(
      alignment: messageProviders.chatlist[index].iaMsender == true
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Column(
//        mainAxisAlignment: messageProviders.chatlist[index].iaMsender == true
//            ? MainAxisAlignment.end
//            : MainAxisAlignment.start,
//        crossAxisAlignment: messageProviders.chatlist[index].iaMsender == true
//            ? CrossAxisAlignment.end
//            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              deleteStatus == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_messageList.contains(
                                  messageProviders.chatlist[index].id) ==
                              false) {
                            _messageList
                                .add(messageProviders.chatlist[index].id);
                          } else {
                            _selectAll = false;
                            _messageList
                                .remove(messageProviders.chatlist[index].id);
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          color: _messageList
                                  .contains(messageProviders.chatlist[index].id)
                              ? Color.fromRGBO(212, 27, 71, 1)
                              : Colors.black,
                          border:
                              Border.all(color: Color.fromRGBO(212, 27, 71, 1)),
                          shape: BoxShape.circle,
                        ),
                        height: 32.0,
                        width: 32.0,
                        child: Center(
                            // Your Widget
                            ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      messageProviders.chatlist[index].iaMsender == true
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  crossAxisAlignment:
                      messageProviders.chatlist[index].iaMsender == true
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 14, right: 10, top: 10, bottom: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.65),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messageProviders.chatlist[index].iaMsender ==
                                  true
                              ? Color.fromRGBO(212, 27, 71, 1)
                              : Color.fromRGBO(55, 52, 52, 1)),
                        ),
                        child: messageProviders.chatlist[index].messageMedia !=
                                null
                            ? SizedBox(
                                width: 200,
                                height: 200,
                                child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: messageProviders
                                          .chatlist[index].messageMedia,
                                    )),
                              )
                            : Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    messageProviders
                                        .chatlist[index].messageBody,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)
                                    // style: TextStyle(
                                    //     fontSize: 14,
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w500)
                                ),
                              )),
                    Container(
                        margin: EdgeInsets.only(left: 14, right: 10),
                        child: Text(
                            getDateFormatMessaging(messageProviders
                                .chatlist[index].createdAt
                                .toLocal()),
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textComposerWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _messageList.length <= 0
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  AnimatedContainer(
                    padding: EdgeInsets.only(bottom: 5),
                    duration: Duration(milliseconds: 375),
                    height: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    width: (toggle == 0) ? 50.0 : 100,
                    curve: Curves.easeOut,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 375),
                          right: 0.0,
                          curve: Curves.easeOut,
                          child: AnimatedOpacity(
                            opacity: (toggle == 0) ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 200),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 375),
                          left: (toggle == 0) ? 10.0 : 30.0,
                          curve: Curves.easeOut,
                          child: AnimatedOpacity(
                            opacity: (toggle == 0) ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 200),
                            child: Container(child:
                                Consumer(builder: (context, watch, child) {
                              final messageProviders = watch(messageProvider);
                              return Container();
                            })),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: (toggle == 0)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color.fromRGBO(212, 27, 71, 1),
                                  ),
                                  color: Color(0x00000000),
                                  onPressed: () {
                                    setState(() {
                                      if (toggle == 0) {
                                        toggle = 1;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _con.forward();
                                      } else {
                                        toggle = 0;
                                        _con.reverse();
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  child: Row(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(gallery_outlined,
                                          color:
                                              Color.fromRGBO(212, 27, 71, 1)),
                                      color: Color(0x00000000),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // Video()),
                                                  CustomGallery(
                                                    commentPostImage: "message",
                                                    userId: widget.userId,
                                                    userName: widget.userName,
                                                  )),
                                        );
                                      },
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: Image.asset(camera_outlined,
                                            color:
                                                Color.fromRGBO(212, 27, 71, 1)),
                                        color: Color(0x00000000),
                                        onPressed: () {
                                          var pic = Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Video(
                                                      commentPostImage:
                                                          "message",
                                                      userId: widget.userId,
                                                      userName: widget.userName,
                                                    )),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                )),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Container(
                    height: 32,
                    padding: EdgeInsets.only(top: 05, bottom: 09, left: 10),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          toggle = 0;
                          _con.reverse();
                        });
                      },
                      controller: _controller,
                      focusNode: focusNode,
                      autofocus: false,
                      style:  GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000)),
                      // TextStyle(
                      //     fontWeight: FontWeight.w500, color: Color(0xff000000)),
                      decoration: InputDecoration.collapsed(
                          hintText: "Type message...",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              height: 1),

                          hoverColor: Color(0xff000000)),
                    ),
                  )),
                  InkWell(
                    onTap: () => submitMessage(),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromRGBO(212, 27, 71, 1),
                      ),
                    ),
                  ),
                ],
              ))
          : Container(
              height: 86,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(34, 34, 34, 1),
              child: deleteClicked != true
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      color: Color.fromRGBO(212, 27, 71, 1),
                      onPressed: () {
                        setState(() {
                          deleteClicked = true;
                        });
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                              _selectAll
                                  ? "Delete ${context.read(messageProvider).chatLength} Message"
                                  : "Delete ${_messageList.length} Message",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  deleteClicked = false;
                                });
                              },
                              child: Text("Cancel",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1)),
                            ),
                            GestureDetector(
                              onTap: ()async {
                                await context.read(messageProvider).deleteMessages(
                                    _messageList, _conversationId, widget.userId, _selectAll);
                                _messageList.clear();
                                deleteStatus=false;
                              },
                              child: Text("Delete",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(212, 27, 71, 1),
                                      height: 1)),
                            ),
                          ],
                        )
                      ],
                    )),
    );
  }

  selectAll() {
    context.read(messageProvider).chatlist.forEach((element) {
      _selectAll = true;
      if (_messageList.contains(element.id) == false) {
        setState(() {
          _messageList.add(element.id);
        });
      }
    });
  }

  submitMessage() async {
    Map map = Map<String, dynamic>();
    map['conversationId'] = context.read(messageProvider).conversationId;
    map['messageBody'] = _controller.text;
    FormData formData = new FormData.fromMap({
      "conversationId": context.read(messageProvider).conversationId,
      "messageBody": widget.file != null ? "Media" : _controller.text,
    });
    if (widget.file != null) {
      String type = widget.file.path.split('.').last;
      String name = widget.file.path.split('/').last;
      String format = imageFileType().indexOf(type) != -1 ? "Image" : "Video";
      MultipartFile fileData = MultipartFile.fromFileSync(widget.file.path,
          filename: name, contentType: MediaType(format, type));
      formData.files.add(MapEntry("chatMedia", fileData));
    }
    var data =
        context.read(messageProvider).sendMessage(map, formData, context);
    if (data != null) {
      FocusScope.of(context).requestFocus(new FocusNode());
      _controller.clear();
    }
  }
}
