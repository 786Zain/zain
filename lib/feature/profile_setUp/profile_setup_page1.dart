import 'package:analyzer/file_system/file_system.dart';
import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/profile_setUp/profile_cropper/profile_setup_cropper.dart';
import 'package:farm_system/feature/profile_setUp/repo/profile_setup.repo.dart';
import 'package:farm_system/feature/set_password/repo/set_password_repo.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileSetupPage1 extends StatefulHookWidget {
  final String value;
  final String password;
  final String userId;
  final String username;
  const ProfileSetupPage1(
      {Key key, this.value, this.password, this.userId, this.username})
      : super(key: key);
  @override
  _ProfileSetupPage1State createState() => _ProfileSetupPage1State();
}

class _ProfileSetupPage1State extends State<ProfileSetupPage1> {
  var _players = ["Youth", "High School", "College", "Professional"];
  bool haveImg;
  var imageFile;
  bool profileSetup = false;
  bool skipNow = true;
  var _currentSelectedValue;
  File file;
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.only(top: 18),
              child: Center(
                child: Container(
                  height: 99,
                  child: SvgPicture.asset(newLogoFarm),
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: 111,
                      width: 121,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 70,
                              height: 29,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(29)),
                                    color: HexColor("#D41B47")),
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: GestureDetector(
                                    child: Icon(Icons.add, color: Colors.white),
                                    // onTap: () =>  ExtendedNavigator.root.push(Routes.cameraExampleHome),
                                    onTap: () {
                                      _showSelectionDialog(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        radius: 80,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile)
                            : AssetImage(dummyUser),
                        //_selectedFile == null?
                        //FileImage(_selectedFile):NetworkImage('https://picsum.photos/250?image=9'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 58,
                ),
                Container(
                    width: 300,
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 18.0),
                              hintText: 'Please select level',
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#E0E0E0")))),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.black,
                              value: _currentSelectedValue,
                              hint: Text(
                                "Competition Level",
                                style: TextStyle(color: Colors.white),
                              ),
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _players.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontSize: 16,
                                        textStyle: TextStyle(fontSize: 14)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    )),
                Divider(
                  color: Colors.white,
                  endIndent: 30,
                  indent: 30,
                  thickness: 1,
                ),
                SizedBox(
                  height: 130,
                ),
                GestureDetector(
                  onTap: () {
                    if (imageFile != null || _currentSelectedValue != null) {
                      ProfileSetupRepo1.selectType(
                          context,
                          widget.value,
                          widget.password,
                          widget.userId,
                          imageFile,
                          _currentSelectedValue);
                    } else {
                      ProfileSetupRepo1.skipNow(context, widget.value,
                          widget.password, widget.userId, skipNow);
                    }
                  },
                  child: Container(
                      height: 60,
                      width: 280,
                      decoration: BoxDecoration(
                        color: HexColor("#D41B47"),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 14, color: HexColor("#ffffff")),
                        ),
                      )),
                ),
                SizedBox(
                  height: 17,
                ),
                GestureDetector(
                  onTap: () {
                    ProfileSetupRepo1.skipNow(context, widget.value,
                        widget.password, widget.userId, skipNow);
                  },
                  child: Container(
                      child: Text(
                    "Skip for now",
                    style: TextStyle(fontSize: 12, color: HexColor("#888A8E")),
                  )),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var photo = await ProfileSetupCopper.cropImageFromGallery();
    setState(() {
      imageFile = photo;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    var photo = await ProfileSetupCopper.cropImageFromCamera();
    setState(() {
      imageFile = photo;
    });
    Navigator.pop(context);
  }
}
