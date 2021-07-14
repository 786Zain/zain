import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/sign_up/repo/sign_up_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerfirstName = TextEditingController();
  TextEditingController controllerlastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  DateTime selectedDate = DateTime(2007, 12, 30);
  bool textEnable;
  Duration initialtimer = new Duration();
  int selectitem = 1;
  String date;

  Widget datetime() {
    DateFormat formatter = new DateFormat.yMd();
    var now = DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);

    return CupertinoDatePicker(
      initialDateTime: today,
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        date = formatter.format(newdate).toString();
        controllerDate.text = date;
        print("here is date for testing purpose");
        print(date);
        new DateFormat.yMd();
        print(formatter.format(newdate));
      },
      maximumYear: now.year,
      backgroundColor: Color.fromRGBO(160, 160, 160, 1),
      mode: CupertinoDatePickerMode.date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          iconSize: 32,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Container(
              padding: EdgeInsets.only(right: 52),
              height: 99,
              child: Center(child: SvgPicture.asset(newLogoFarm))),
        ),
        centerTitle: true,
        backgroundColor: Colors.black
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 154,
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                      enabled: textEnable,
                      controller: controllerfirstName,
                      textCapitalization: TextCapitalization.values[0],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: HexColor("#E0E0E0"),
                              width: 1.5,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: HexColor("D41B47"),
                        ),
                        hintText: "First Name",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            // color: HexColor("080F18"),
                            color: Colors.white,
                            fontSize: 14,
                            textStyle: TextStyle(fontSize: 14)),
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                      enabled: textEnable,
                      controller: controllerlastName,
                      textCapitalization: TextCapitalization.values[0],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: HexColor("#E0E0E0"),
                              width: 1.5,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: HexColor("D41B47"),
                        ),
                        hintText: "Last Name",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                            textStyle: TextStyle(fontSize: 14)),
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                      cursorColor: Colors.white,
                      controller: controllerEmail,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Phone Number or Email ",
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: HexColor("D41B47"),
                        ),
                        disabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: HexColor("#E0E0E0"),
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 1.5,
                          color: HexColor("#E0E0E0"),
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: HexColor("#E0E0E0"),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                      enabled: textEnable,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.white),
                      controller: controllerDate,
                      onSaved: (value) {
                        controllerDate.text =
                            selectedDate.toLocal().toIso8601String();
                      },
                      maxLines: 1,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext builder) {
                              return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height /
                                      3,
                                  child: datetime());
                            });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: HexColor("D41B47"),
                          ),
                          hintText: "Date of Birth",
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HexColor("#E0E0E0"),
                                width: 1.5,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.white,
                          ))
                          )),
                ),
                SizedBox(
                  height: 196,
                ),
                Container(
                    height: 60,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(192, 29, 68, 1),
                      borderRadius: BorderRadius.circular(105),
                    ),
                    child: FlatButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(105)),
                      onPressed: () {
                        textEnable = false;
                        SignUpRepo.register(
                            context,
                            controllerfirstName.text,
                            controllerlastName.text,
                            controllerEmail.text,
                            controllerDate.text);
                      },
                      child: Center(
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
