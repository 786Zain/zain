import 'package:farm_system/common/custom_widget.dart';
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/dashboard/dashboard.dart';
import 'package:farm_system/feature/profile_setUp/repo/profile_page_two_repo.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileSetupPage2 extends StatefulWidget {
  final String value;
  final String password;
  final String userId;
  final bool skip;

  const ProfileSetupPage2(
      {Key key, this.value, this.password, this.userId, this.skip})
      : super(key: key);

  @override
  _ProfileSetupPage2State createState() => _ProfileSetupPage2State();
}

class _ProfileSetupPage2State extends State<ProfileSetupPage2> {
  var _players = [
    "State",
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ];
  String _currentSelectedValue = "State";
  final _bioC = TextEditingController();
  final _city = TextEditingController();
  final _website = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 25,),
                onPressed: (){
              Navigator.pop(context);
        },


                //Navigator.of(context).pop(CustomWidget.loader(false, context)),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Container(
                padding: EdgeInsets.only(right: 52),
                height: 99,
                child: Center(child: SvgPicture.asset(newLogoFarm))),
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
                height: 20,
              ),
              Text(
                "Profile Set-up",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 152,
                width: 328,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _bioC,
                  maxLines: 80,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: HexColor("#E0E0E0"),
                        width: 1.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor("#E0E0E0"), width: 1.5),
                      ),
                      hintText: "Bio...",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 16)),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    margin: EdgeInsets.fromLTRB(28, 0, 28, 0),
                    child: TextFormField(
                        cursorColor: Colors.white,
                        controller: _city,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: HexColor("#E0E0E0"),
                            width: 1.5,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor("#E0E0E0"), width: 1.5),
                          ),
                          hintText: "City",
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 14),
                        )),
                  ),
                  Container(
                    height: 57,
                    width: 133,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 18.0),
                              hintText: 'Please select state',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            child: DropdownButton<String>(
                              underline: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black),
                                  ),
                                ),
                              ),
                              value: _currentSelectedValue,
                              dropdownColor: Colors.black,
                              isDense: true,
                              isExpanded: true,
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
                                        fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ));
                      },
                    ),
                  ),
                  Divider(
                    indent: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                //248 248 248
                height: 57,
                width: 328,
                margin: EdgeInsets.fromLTRB(24, 0, 23, 0),
                child: TextFormField(
                    cursorColor: Colors.white,
                    controller: _website,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: HexColor("#E0E0E0"),
                          width: 1.5,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor("#E0E0E0"), width: 1.5),
                        ),
                        hintText: "Website",
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Text(
                            "(optional)",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ))),
              ),
              SizedBox(
                height: 67,
              ),
              GestureDetector(
                onTap: () {
                  ProfileSetupTwoRepo.profileTwo(
                      context,
                      _bioC.text,
                      _city.text,
                      _currentSelectedValue,
                      _website.text,
                      widget.value,
                      widget.password,
                      widget.userId);
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
                        "Finish",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  print('dhsdhsdvhsv');
                  print(widget.skip);
                  ProfileSetupTwoRepo.skipNow(context, widget.value,
                      widget.password, widget.userId, true);
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
    );
  }
}
