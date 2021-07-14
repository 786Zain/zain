import 'package:farm_system/feature/farm_plus_subscribe_setup/farm_plus_sing_up/view/payment.view.dart';
import 'package:farm_system/riverpod/riverpods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';


class OneYearButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch){
    final repo = watch(farmPlusProvider);
    return
      Column(
      children: [
        Container(
          color: Colors.white,
          height: 20,
          width: 80,
          margin: EdgeInsets.only(right: 240),
          child: Padding(
            padding: const EdgeInsets.only(left: 1,top: 3),
            child: Text('Best Value',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            height: 60,
            decoration: BoxDecoration(
              color: HexColor("#D41B47"),
              border: Border.all(color: Colors.white, width: 5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: FlatButton(
              onPressed: () {
                repo.ActiveButton('OneYear');
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
            )),
      ],
    );
  }
}
