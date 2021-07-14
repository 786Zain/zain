import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/profile_setUp/profile_setup_page1.dart';
import 'package:farm_system/feature/set_password/repo/set_password_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SetPasswordScreen extends StatefulWidget {
  final String value;
  final String userId;
  const SetPasswordScreen({Key key, this.value, this.userId}) : super(key: key);
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerResetPassword = TextEditingController();

  bool _isVisiblePassword = true;
  bool _isVisibleConfirmPassword = true;
  bool shouldPop = false;

  var _currencies = [
    "Coach",
    "Player",
    "Athletic admin",
  ];

  var _currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top: 18),
            child: Center(
              child: Container(
                height: 99,
                child: SvgPicture.asset(newLogoFarm) ,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 11,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 44.0),
                      margin: EdgeInsets.only(top: 64.0, left: 35.0, right: 28.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 18.0),
                                hintText: 'Please select the Level',
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white))),
                            isEmpty: _currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.black,
                                value: _currentSelectedValue,
                                isDense: true,
                                elevation: 10,
                                hint: Text(
                                  "What Best Describes You?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedValue = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _currencies.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 16,
                                          textStyle: TextStyle(
                                              fontSize: 14, color: Colors.white)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 76.0, left: 45.0),
                      child: Icon(
                        Icons.person_outline,
                        color: HexColor("D41B47"),
                        size: 25,
                      ),
                    ),
                  ],
                ),
                // Divider(
                //   color: Colors.white,
                //   endIndent: 30,
                //   indent: 30,
                //   thickness: 1,
                // ),
                SizedBox(
                  height: 47,
                ),
                Container(
                  height: 57,
                  width: 328,
                  margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
                  child: TextFormField(
                      cursorColor: Colors.white,
                      controller: _controllerUsername,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: HexColor("D41B47"),
                          size: 20,
                        ),
                        hintText: "Username",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                            textStyle: TextStyle(fontSize: 14)),
                      )),
                ),
                SizedBox(
                  height: 47,
                ),
                Container(
                  height: 57,
                  width: 328,
                  margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
                  child: TextFormField(
                      obscureText: _isVisiblePassword ? true : false,
                      controller: _controllerPassword,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.padlock,
                          color: HexColor("D41B47"),
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          color: HexColor("C4C4C4"),
                          onPressed: () {
                            setState(() {
                              _isVisiblePassword = !_isVisiblePassword;
                            });
                          },
                          icon: _isVisiblePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility_rounded),
                        ),
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                            textStyle: TextStyle(fontSize: 14)),
                      )),
                ),
                SizedBox(
                  height: 47,
                ),
                Container(
                  height: 57,
                  width: 328,
                  margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
                  child: TextFormField(
                      cursorColor: Colors.white,
                      obscureText: _isVisibleConfirmPassword ? true : false,
                      controller: _controllerResetPassword,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.padlock,
                          color: HexColor("D41B47"),
                        ),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          color: HexColor("C4C4C4"),
                          onPressed: () {
                            setState(() {
                              _isVisibleConfirmPassword = !_isVisibleConfirmPassword;
                            });
                          },
                          icon: _isVisibleConfirmPassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility_rounded),
                        ),
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                            textStyle: TextStyle(fontSize: 14)),
                      )),
                ),
                SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: ()  {
                    if (_controllerPassword.text ==
                        _controllerResetPassword.text) {
                      SetPasswordRepo.setPassword(
                          context,
                          widget.value,
                          widget.userId,
                          _currentSelectedValue,
                          _controllerUsername.text,
                          _controllerPassword.text);
                    } else {
                      CustomWidget.showWarningFlushBar(
                          context, 'Password mis match!');
                    }
                  },
                  child: Container(
                      height: 60,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(192, 29, 68, 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Finish",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
