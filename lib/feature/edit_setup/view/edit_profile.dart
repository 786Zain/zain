import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/profile_user/view/profiletab.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'backgraound_gallery.dart';
import 'gallery_editpage.dart';

class EditProfile extends StatefulWidget {
  get subCategory => null;
  final String userId;
  final File filePath;
  final File filePaths;
  final File cropImgae;
  final File cropCoverPic;

  const EditProfile({Key key,
    this.userId,
    this.filePath,
    this.filePaths,
    this.cropImgae,
    this.cropCoverPic})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controlleruserName = TextEditingController();
  TextEditingController controllerBio = TextEditingController();
  TextEditingController controllerLocation = TextEditingController();
  TextEditingController controllerWebsite = TextEditingController();
  DateTime selectedDate = DateTime(2007, 12, 30);

  String comp = '';

  Duration initialtimer = new Duration();
  int selectitem = 1;
  String date;
  bool birthDateStatus = false;
  String editProfile = 'Edit Profile';
  String cropProfile = 'Crop Profile';
  String _currentSelectedValue;

  List<String> _locations = [
    'Youth',
    'High School',
    'College',
    'Professional'
  ]; // Option 2
  String _selectedLocation;

  @override
  void initState() {
    // For Hiding he video show in gallery here

    super.initState();
  }

  Widget datetime() {
    DateFormat formatter =
    new DateFormat.yMd(); //specifies day/month/year format

    return CupertinoDatePicker(
      initialDateTime: DateTime(2007, 12, 30),
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        date = formatter.format(newdate).toString();
        controllerDate.text = date;
        birthDateStatus = true;
        print("here is date for testing purpose");
        print(date);
        new DateFormat.yMd();
        print(formatter.format(newdate));
      },
      // use24hFormat: true,
      maximumDate: new DateTime(2007, 12, 30),
      minimumYear: 1970,
      maximumYear: 2007,
      // minuteInterval: 1,
      mode: CupertinoDatePickerMode.date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          child: Consumer(builder: (context, watch, child) {
            final postRepo = watch(postProvider);
            return InkWell(
                child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Cancel",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            wordSpacing: 2,
                            letterSpacing: 0))),
                onTap: () async {
                  navigationToScreen(
                      context, ProfileTab(userId: widget.userId), false);
                  await postRepo.restCropperfile();
                });
          }),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.montserrat(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer(builder: (context, watch, child) {
            final editProvider = watch(editProfileProvider);
            final profileRepo = watch(profileProvider);
            final dashboardRepo = watch(dashboardProvider);
            final userProfileAllRepo = watch(userAllProvider);
            final postRepo = watch(postProvider);
            return Container(
              child: Center(
                child: InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text("SAVE",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                wordSpacing: 2,
                                letterSpacing: 0))),
                    onTap: () async {
                      // final userIds = await StorageService.getUserId();
                      File myFile =
                      profileRepo.userProfileDeatils.profilePic.length != 0 ?
                      File(profileRepo
                          .userProfileDeatils.profilePic[0].location)
                          : File(dashboardRepo.userProfilePic);

                      if (widget.cropImgae != null ||
                          widget.cropCoverPic != null) {
                        await editProvider.editProfileInfo(
                            context,
                            controlleruserName.text,
                            controllerBio.text,
                            controllerLocation.text,
                            controllerDate.text,
                            widget.filePath,
                            widget.filePaths,
                            widget.cropImgae,
                            widget.cropCoverPic,
                            birthDateStatus,
                            _selectedLocation,
                            controllerWebsite.text,
                            widget.userId);
                        await userProfileAllRepo.userProfileAll(widget.userId);
                        await dashboardRepo.fetchUserDetail();
                        // await profileRepo.getUserProfileInfo(userIds);
                      } else {
                        await editProvider.editProfileInfo(
                            context,
                            controlleruserName.text,
                            controllerBio.text,
                            controllerLocation.text,
                            controllerDate.text,
                            widget.filePath,
                            widget.filePaths,
                            myFile,
                            widget.cropCoverPic,
                            birthDateStatus,
                            _selectedLocation,
                            controllerWebsite.text,
                            widget.userId);
                        await userProfileAllRepo.userProfileAll(widget.userId);
                        await dashboardRepo.fetchUserDetail();

                        // await profileRepo.getUserProfileInfo(userIds);
                      }
                    }),
              ),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Consumer(builder: (context, watch, child) {
                final profileProviderRepo = watch(profileProvider);
                return AsyncLoader(
                  initState: () async =>
                  await profileProviderRepo
                      .getUserProfileInfo(widget.userId),
                  renderLoad: () => CircularProgressIndicator(),
                  renderError: ([err]) => Text('There was a error'),
                  renderSuccess: ({data}) => _generateUI(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Consumer _generateUI() {
    return Consumer(builder: (context, watch, child) {
      final profileRepo = watch(profileProvider);
      final dashBoardProviderRepo = watch(dashboardProvider);
      controlleruserName.text = controlleruserName.text != ""
          ? controlleruserName.text
          : profileRepo.userProfileDeatils.name;
      controllerBio.text = controllerBio.text != ""
          ? controllerBio.text
          : profileRepo.userProfileDeatils.bio;
      controllerLocation.text = controllerLocation.text != ""
          ? controllerLocation.text
          : profileRepo.userProfileDeatils.city;
      _currentSelectedValue = profileRepo.userProfileDeatils.category;
      controllerWebsite.text = controllerWebsite.text != ""
          ? controllerWebsite.text
          : profileRepo.userProfileDeatils.website;
      return profileRepo.userProfileDeatils.id != null
          ? Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: [
              Stack(
                overflow: Overflow.visible,
                alignment: Alignment.bottomLeft,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BackgroundEditGallery(
                                    commentPostImage: editProfile,
                                  )),
                        );
                      },
                      child: widget.cropCoverPic != null
                          ? Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height / 5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(widget.cropCoverPic),
                              fit: BoxFit.cover,
                            )),
                      )
                          : profileRepo.userProfileDeatils.profilePic
                          .length >
                          1
                          ? Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height /
                            5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(profileRepo
                                  .userProfileDeatils
                                  .profilePic[1]
                                  .location),
                              fit: BoxFit.cover,
                            )),
                      )
                          : Container(
                        margin:
                        EdgeInsets.only(left: 10, right: 10),
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(),
                        child: SvgPicture.asset(
                          logo_text_left,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 7.5,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditGallery(
                                    commentPostImage: cropProfile,
                                  )),
                        );
                      },
                      child: widget.cropImgae != null
                          ? Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(widget.cropImgae))))
                          : profileRepo.userProfileDeatils.profilePic.length != 0?
                      //profileRepo.userProfileDeatils.profilePic[0].location.isNotEmpty?
                      Container(
                        width: 86.0,
                        height: 86.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profileRepo
                                .userProfileDeatils
                                .profilePic[0]
                                .location),
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      ): Container(
                        width: 86.0,
                        height: 86.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: NetworkImage(
                                dashBoardProviderRepo.userProfilePic),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: new BorderRadius.all(
                              new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NAME',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.4,
                        // width: 280,
                        child: TextField(
                          controller: controlleruserName,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.montserrat(color: HexColor(
                              "D41B47"), fontSize: 12.0),
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 40, top: 0),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BIO',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.4,
                        // width: 280,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: controllerBio,
                          cursorColor: Colors.white,
                          style: GoogleFonts.montserrat(color: HexColor(
                              "D41B47"), fontSize: 12),
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 40, top: 0),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Colors.grey[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 28,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'CITY',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      child: Padding(
                        padding:
                        EdgeInsets.only(right: 20, bottom: 4, left: 20),
                        child: TextFormField(
                            controller: controllerLocation,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.montserrat(
                                color: HexColor("D41B47"), fontSize: 12),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 28,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'BIRTH DATE',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 28,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, bottom: 4),
                          child: TextFormField(
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.montserrat(
                                  color: HexColor("D41B47"), fontSize: 12.0),
                              controller: controllerDate,
                              onSaved: (value) {
                                controllerDate.text = selectedDate
                                    .toLocal()
                                    .toIso8601String();
                              },
                              maxLines: 1,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                          height: MediaQuery
                                              .of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                              3,
                                          child: datetime());
                                    });
                              },
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                ),
                                contentPadding:
                                EdgeInsets.only(left: 20, bottom: 10),
                                hintText: profileRepo
                                    .userProfileDeatils.birthDate,
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: HexColor("D41B47"),
                                ),
                              )),
                        ),
                      ),
                      onTap: () {
                        birthDateStatus = true;
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 28,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6,),
                        child: Text(
                          'COMP. LEVEL',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 11,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    Container(
                        height: 28,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 14),
                                errorStyle: TextStyle(
                                    color: HexColor("D41B47"),
                                    fontSize: 12.0),
                              ),
                              isEmpty: _currentSelectedValue == '',
                              child: Container(
                                height: 20,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  dropdownColor: Colors.black,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 12),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  iconEnabledColor: Colors.white,
                                  // iconSize: 25,
                                  isExpanded: true,
                                  hint: Text(
                                    _currentSelectedValue,
                                    style: GoogleFonts.montserrat(
                                        color: HexColor("D41B47"),
                                        fontSize: 12.0
                                    ),
                                  ),
                                  // Not necessary for Option 1
                                  value: _selectedLocation,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  items: _locations.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(
                                        location,
                                        style: GoogleFonts.montserrat(
                                            color: HexColor("D41B47"),
                                            fontSize: 12),
                                      ),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 28,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'WEBSITE',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    Container(
                        height: 28,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.4,
                        child: TextField(
                          controller: controllerWebsite,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.montserrat(
                              color: HexColor("D41B47"),
                              fontSize: 12.0
                          ),
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 40, bottom: 15),
                            hintText: 'Add your website',
                            hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[900],
              ),
            ],
          ))
          : Center(
          child: Container(height: 20, child: CircularProgressIndicator()));
    });
  }
}
