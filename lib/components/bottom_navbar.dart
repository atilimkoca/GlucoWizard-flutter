import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  var listOffline = [
    Icon(FontAwesomeIcons.handHoldingMedical, size: 30, color: Colors.white),
    Icon(LineIcons.stethoscope, size: 40, color: Colors.white),
    Icon(LineIcons.dna, size: 40, color: Colors.white),
    Icon(LineIcons.syringe, size: 40, color: Colors.white)
  ];
  var listOnline = [
    Icon(
      FontAwesomeIcons.chartLine,
      size: 30,
      color: Colors.white,
      semanticLabel: 'test',
    ),
    Icon(FontAwesomeIcons.handHoldingMedical, size: 30, color: Colors.white),
    Icon(LineIcons.stethoscope, size: 40, color: Colors.white),
    Icon(LineIcons.dna, size: 40, color: Colors.white),
    Icon(LineIcons.capsules, size: 40, color: Colors.white),
    Icon(Icons.alarm, size: 37, color: Colors.white),
    Icon(LineIcons.userCircle, size: 40, color: Colors.white),
  ];

  BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginPageProvider>(context);
    pages() {
      if (loginProvider.offline) {
        return listOffline;
      } else {
        return listOnline;
      }
    }

    onTap(index) {
      context.read<BottomNavBarProvider>().onItemTapped(index);
      context.read<AppBarProvider>().setTitle(index, context);
    }

    return CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 213, 196, 238),
        color: Color.fromARGB(255, 142, 97, 209),
        height: MediaQuery.of(context).size.height * 0.07,
        animationDuration: Duration(milliseconds: 200),
        items: pages(),
        onTap: onTap);
  }
}
