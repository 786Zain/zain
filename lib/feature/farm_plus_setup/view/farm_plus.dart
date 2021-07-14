import 'package:farm_system/feature/farm_plus_setup/view/widgets/image_section.dart';
import 'package:farm_system/feature/farm_plus_setup/view/widgets/images_list.dart';
import 'package:farm_system/feature/farm_plus_setup/view/widgets/options_button.dart';
import 'package:farm_system/feature/message/view/conversations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class FarmPlusPage extends StatefulWidget {
  bool farmPlusAppBar;
  FarmPlusPage({this.farmPlusAppBar});

  @override
  _FarmPlusPageState createState() => _FarmPlusPageState();

}

class _FarmPlusPageState extends State<FarmPlusPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              appBar: widget.farmPlusAppBar ?
              AppBar(
                backgroundColor:Colors.black,
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
                ),
                title:  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  height: 40,
                  margin: EdgeInsets.only(
                    left: 0,
                    right: 10,
                    top: 10,
                  ),
                  child: TextFormField(
                    showCursor: false,
                    cursorColor: Colors.white,
                    onChanged: (value) {},
                    enableSuggestions: false,
                    autocorrect: false,
                    style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search Farm+',
                      contentPadding: EdgeInsets.only(bottom: 2, top: 4),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ): null,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ImageSection(),
                    SizedBox(
                      height: 5,
                    ),
                    OptionsButton(),
                    SizedBox(
                      height: 10.0,
                    ),
                   ImagesListView(),
                  ],
                ),
              ))),
    );
  }
}

