import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
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
        color: Color(0xff3AB4F2),
        height: MediaQuery.of(context).size.height * 0.07,
        animationDuration: Duration(milliseconds: 200),
        items: const <Widget>[
          Icon(Icons.add_chart, size: 30, color: Colors.white),
          Icon(Icons.health_and_safety, size: 30, color: Colors.white),
          Icon(Icons.online_prediction, size: 30, color: Colors.white),
          Icon(Icons.textsms_sharp, size: 30, color: Colors.white),
          Icon(Icons.alarm, size: 30, color: Colors.white),
        ],
        onTap: onTap);
  }
}
