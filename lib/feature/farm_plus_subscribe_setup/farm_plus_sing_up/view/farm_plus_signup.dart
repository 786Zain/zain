
import 'package:farm_system/constant/constants.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_description/view/description_page.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/oneMonthSubscription.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/payment.view.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/widget/onemonth_button.dart';
import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/widget/oneyear_button.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:farm_system/screen/Discovery/all_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FarmPlusSignUp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch){
    final repo = watch(farmPlusProvider);
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
          children: [
            Container(
              height: 250,
              width: 400,
              child: Image.asset(farm_plus_logo),
            ),
            SizedBox(height: 30,),
            !repo.isOneMonth ?
            Container(
                margin: EdgeInsets.only(left: 30,right: 30),
                height: 60,
                decoration: BoxDecoration(
                  color: HexColor("#D41B47"),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: FlatButton(
                  onPressed: () {
                    repo.ActiveButton('OneMonth');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OneMonthSubscription()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "1 Month",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        "\$9.99/Monthly",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                )) : HighLightButton(),
            SizedBox(height: 50,),

            !repo.isOneYear ?
            Container(
                margin: EdgeInsets.only(left: 30,right: 30),
                height: 60,
                decoration: BoxDecoration(
                  color: HexColor("#D41B47"),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: FlatButton(
                  onPressed: () {
                    repo.ActiveButton('OneYear');
                    // InApp
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InApp()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "1 Year",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        "\$100/Yearly",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),

                )) : OneYearButton(),
            SizedBox(height: 100,),
            Container(
                margin: EdgeInsets.only(left: 30,right: 30),
                height: 60,
                decoration: BoxDecoration(
                  color: HexColor("#D41B47"),
                  borderRadius: BorderRadius.circular(105),
                ),
                child: FlatButton(
                  onPressed: () {
                    print('Subscribe');
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
            SizedBox(height: 5,),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Container(
                      child: Text(
                        "What do I get with Farm+?",
                        style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
  }

