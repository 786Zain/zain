import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_system/common/methods.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/feed/subCommentFullView/model/nestedreplyview.modal.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class RepeatInsideSubCommentNested extends StatefulWidget {

  final DatumModel insideSubCommentNestedDetails;

  const RepeatInsideSubCommentNested({Key key, this.insideSubCommentNestedDetails}) : super(key: key);

  @override
  _RepeatInsideSubCommentNestedState createState() => _RepeatInsideSubCommentNestedState();
}

class _RepeatInsideSubCommentNestedState extends State<RepeatInsideSubCommentNested> {


  final _captionControllerInsideSubComment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer(
          builder: (context, watch, child){

            final dashBoardProviderRepo = watch(dashboardProvider);
            final repeatSubCommentProviderRepo = watch(repeatSubCommentPostProvider);

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 10.0,left: 50),
                        child: Container(
                            height: 89,
                            child: SvgPicture.asset(newLogoFarm,
                                height: 120, width: 120, fit: BoxFit.scaleDown)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async {

                          await repeatSubCommentProviderRepo.repeatSubCommentPost(context, widget.insideSubCommentNestedDetails.id, _captionControllerInsideSubComment.text);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Quote",
                            style: TextStyle(fontSize: 14, letterSpacing: 2)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                  visible:
                                  dashBoardProviderRepo.userProfilePic !=
                                      null,
                                  child: Container(
                                      height: 52,
                                      width: 52,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image:  NetworkImage(
                                                  getImageUrl(
                                                      dashBoardProviderRepo
                                                          .userProfilePic) ??
                                                      ''))))),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, top: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            new Radius.circular(10.0)),
                                        color: Colors.white30),
                                    child: TextFormField(
                                      controller: _captionControllerInsideSubComment,
                                      style: TextStyle(color: Colors.white),
                                      autofocus: true,
                                      minLines: 1,
                                      maxLines: null,
                                      maxLengthEnforced: true,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "What's happening?",
                                        // hintStyle: GoogleFonts.poppins(
                                        //   fontWeight: FontWeight.w400,
                                        //   fontSize: 15,
                                        //   color: Colors.white,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Color(0xff222222)),
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: 2, right: 8, left: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(20)),
                                                    child:
                                                    CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        height: 40,
                                                        width: 40,
                                                        imageUrl: widget.insideSubCommentNestedDetails.userPic)
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10, top: 10),
                                                child: Text( Utils.getCapitalizeName(widget.insideSubCommentNestedDetails.userFullname),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                    )
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10, top: 10),
                                                child: Text('@${widget.insideSubCommentNestedDetails.userName}',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0xff666666)
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                          widget.insideSubCommentNestedDetails.commentMessage != "" && widget.insideSubCommentNestedDetails.commentMessage != null ?
                                          Text(widget.insideSubCommentNestedDetails.commentMessage,
                                              style:GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white54,
                                                  letterSpacing: 0.5
                                              )
                                          ): Text('')
                                        ],
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );

          },
        ),
      ),
    );
  }
}
