import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_description/view/widget/fp_image_section.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_description/view/widget/read_more_page.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/farm_plus_signup.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(top: 18.0,right: 40),
          child: Center(
            child: Container(
                height: 99,
                child: SvgPicture.asset(newLogoFarm,
                    height: 120, width: 120, fit: BoxFit.cover)),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(top: 7),
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 25)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(child: FarmPlusImageSection()),
            SizedBox(
              height: 15,
            ),
             ReadMorePage(),
          ],
        ),
      ),
      bottomNavigationBar:Container(
          margin: EdgeInsets.only(left: 30,right: 30, bottom: 20),
          height: 60,
          decoration: BoxDecoration(
            color: HexColor("#D41B47"),
            borderRadius: BorderRadius.circular(105),
          ),
          child: FlatButton(
            onPressed: () {
              navigationToScreen(context, FarmPlusSignUp(), false);
            },
            child: Center(
              child: Text(
                "Subscribe",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white,
                    fontStyle: FontStyle.normal),
              ),
            ),
          )),
    );
  }
}
