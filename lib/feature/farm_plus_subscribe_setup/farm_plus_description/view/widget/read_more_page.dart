import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ReadMorePage extends StatefulWidget {
  const ReadMorePage({Key key}) : super(key: key);

  @override
  _ReadMorePageState createState() => _ReadMorePageState();
}

class _ReadMorePageState extends State<ReadMorePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'What Does A Farm+ Have To Offer?',
              style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#FF0000"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Text(
              'Farm+ members receive full access to all of our current and future courses.',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Farm Drills',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#FF0000"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 25, left: 25),
            child: Text(
              'Farm+ members receive full access to our database of 100+ drills featuring:\n'
              '\n-  Hitting drills tailored for more efficient movement and force transmission!'
              '\n-  Pitching drills specified for arm health and strength!'
              '\n-  Strength & performance drills that will help performance transfer onto the field!'
              '\n-  Farmboard drills that we are integrating with our professional clientele!'
              '\n-  In depth drill explenations and breakdowns.',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Farm Prep',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#FF0000"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Text(
              'FarmPrep gives you full access to movement prep we use with our athletes before sessions and includes:\n'
                  '\n- Applicable takeaways you can use with your athletes in todays sessions!'
                  '\n- Muscle activation routines, fascial sling hyration, and incorporate the same movements we want to create in the cage!'
                  '\n- Prep work before hitting is not new, hitters have been preparing to hit since the origins of baseball. This resource just applies a science driven approach to getting your body ready to hit while building new movement capabilities.',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Farm+ Exclusive',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#FF0000"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Text(
              'Farm+ Exclusives gives you our eyes and show you how we view human movement through:\n'
                  '\n- Swing breakdowns featuring some of the best players in the game.'
                  '\n- See the Before and Afters as players make changes.'
                  '\n- Presentations on different aspects of player development.'
                  '\n- Defensive strategy sessions',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Myth VS Fact',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#FF0000"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Text(
              'Mini-episodes featuring the most common terms in baseball & Softball that we dub Myth Vs Fact:\n'
                  '\n- What is really happening vs misunderstood concepts.'
                  '\n- Were the Old School coaches right? Are the New School concepts misguided?'
                  '\n- What are you missing in the swing?',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
