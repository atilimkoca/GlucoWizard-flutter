import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    onTap(index) {
      context.read<BottomNavBarProvider>().onItemTapped(index);
      context.read<AppBarProvider>().setTitle(index, context);
    }

    return CurvedNavigationBar(
        backgroundColor: Color(0xffC3F8FF),
        color: Color.fromARGB(255, 192, 131, 183),
        height: MediaQuery.of(context).size.height * 0.07,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          // Image(
          //   image: AssetImage('assets/images/bottom_chart.png'),
          //   width: 32,
          // ),
          // Image(
          //   image: AssetImage('assets/images/health_bottom.png'),
          //   width: 32,
          // ),
          // Image(
          //   image: AssetImage('assets/images/diagnose_bottom.png'),
          //   width: 32,
          // ),
          // Image(
          //   image: AssetImage('assets/images/type1_prediction_bottom.png'),
          //   width: 32,
          // ),
          // Image(
          //   image: AssetImage('assets/images/alarm_bottom.png'),
          //   width: 32,
          // ),
          // Image(
          //   image: AssetImage('assets/images/bottom_chart.png'),
          //   width: 32,
          // ),
          Icon(
            FontAwesomeIcons.chartLine,
            size: 30,
            color: Colors.white,
            semanticLabel: 'test',
          ),
          Icon(FontAwesomeIcons.handHoldingMedical,
              size: 30, color: Colors.white),
          Icon(LineIcons.stethoscope, size: 40, color: Colors.white),
          Icon(LineIcons.dna, size: 40, color: Colors.white),
          Icon(Icons.alarm, size: 37, color: Colors.white),
          Icon(LineIcons.userCircle, size: 40, color: Colors.white),
          Icon(LineIcons.syringe, size: 40, color: Colors.white)
        ],
        onTap: onTap);
  }
}
