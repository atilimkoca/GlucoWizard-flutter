import 'dart:io';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/components/bottom_navbar.dart';
import 'package:glucowizard_flutter/l10n/l10.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';

import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/prediction_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';
import 'package:glucowizard_flutter/views/alarms_page.dart';
import 'package:glucowizard_flutter/views/diagnose_page.dart';
import 'package:glucowizard_flutter/views/login_page.dart';
import 'package:glucowizard_flutter/views/prediction_page.dart';
import 'package:glucowizard_flutter/views/tracking_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/language_provider.dart';

import 'health_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Time _time = Time(hour: 11, minute: 30, second: 20);

    var trackingChartProvider =
        Provider.of<TrackingChartProvider>(context, listen: true);
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    TextEditingController popupController = TextEditingController();
    var lang =
        languageProvider.locale ?? Locale(Platform.localeName.split('_')[0]);

    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('TextField in Dialog'),
                  content: TextField(
                    controller: popupController,
                    decoration:
                        const InputDecoration(hintText: "Text Field in Dialog"),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              value: context
                                  .watch<TrackingChartProvider>()
                                  .checkboxValue,
                              onChanged: (selected) {
                                context
                                    .read<TrackingChartProvider>()
                                    .setcheckboxValue(
                                        trackingChartProvider.checkboxValue!
                                            ? false
                                            : true);

                                Navigator.of(context).push(
                                  showPicker(
                                    barrierDismissible: false,
                                    is24HrFormat: true,
                                    context: context,
                                    value: _time,
                                    onChange: (time) {},
                                    onChangeDateTime: (p0) {
                                      var stringDate = p0.toString();
                                      const dateTimeString =
                                          '2020-07-17T03:18:31.177769-04:00';
                                      final dateTime = DateTime.parse(
                                          stringDate.replaceFirst(
                                              RegExp(r'-\d\d:\d\d'), ''));

                                      final format = DateFormat.Hm();
                                      final clockString =
                                          format.format(dateTime);
                                      var testTime = DateTime.parse(
                                          trackingChartProvider.currentDate! +
                                              'T' +
                                              clockString);
                                      print(testTime); // 03:18 AM
                                      var formatter = DateFormat.Hm();
                                      if (languageProvider.locale.toString() ==
                                          'tr_TR') {
                                        formatter = DateFormat.Hm();
                                      } else {
                                        formatter = DateFormat.jm();
                                      }

                                      String formattedHour =
                                          formatter.format(p0);
                                      //print(formattedHour);
                                      context
                                          .read<TrackingChartProvider>()
                                          .setCurrentHour(formattedHour);
                                      context
                                          .read<TrackingChartProvider>()
                                          .setcheckboxValue(false);

                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      context
                                          .read<TrackingChartProvider>()
                                          .setcheckboxValue(true);

                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Anlık değer'),
                            )
                          ],
                        ),
                        MaterialButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: const Text('OK'),
                          onPressed: () {
                            // var date = DateTime.now();
                            // var formatter = DateFormat('yyyy-MM-dd');
                            //String formattedDate = formatter.format(date);

                            var currentDate = trackingChartProvider.currentDate;
                            var currentHour = trackingChartProvider.currentHour;
                            TrackingChart chart = TrackingChart(
                                uid: context.read<LoginPageProvider>().userId,
                                date: currentDate,
                                hour: currentHour,
                                glucoseLevel: popupController.text);
                            context
                                .read<TrackingChartProvider>()
                                .addTrackingChart(chart,
                                    trackingChartProvider.checkboxValue!);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                );
              })
          .then((value) =>
              context.read<TrackingChartProvider>().setcheckboxValue(true));
    }

    FirebaseAuth auth = FirebaseAuth.instance;

    var pageIndex = context.watch<BottomNavBarProvider>().selectedIndex;

    title2(String val) {
      switch (val) {
        case 'tr':
          return 'Türkçe';
        case 'en':
          return 'English';
        default:
          return 'Türkçe';
      }
    }

    selectPage(int pageIndex) {
      switch (pageIndex) {
        case 0:
          return TrackingPage();

        case 1:
          return const HealthPage();
        case 2:
          return DiagnosePage();
        case 3:
          return const PredictionPage();
        case 4:
          return const AlarmsPage();
        default:
          return DiagnosePage();
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 239, 245),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton2(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xff3AB4F2),
                        ),
                        elevation: 8,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thumbVisibility: MaterialStateProperty.all(true),
                        )),
                    menuItemStyleData: const MenuItemStyleData(),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                    ),
                    value: lang,
                    onChanged: (Locale? val) {
                      context.read<LanguageProvider>().setLocale(val!);
                      var predictionProvider = Provider.of<PredictionProvider>(
                          context,
                          listen: false);
                      var head = predictionProvider.head;
                      if (head == '15 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('15 Minute');
                      } else if (head == '15 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('15 Dakika');
                      } else if (head == '30 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('30 Minute');
                      } else if (head == '30 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('30 Dakika');
                      } else if (head == '45 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('45 Minute');
                      } else if (head == '45 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('45 Dakika');
                      } else if (head == '60 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('60 Minute');
                      } else if (head == '60 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('60 Dakika');
                      } else if (head == '90 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('90 Minute');
                      } else if (head == '90 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('90 Dakika');
                      } else if (head == '120 Dakika' &&
                          languageProvider.locale.toString() == 'en') {
                        predictionProvider.setHead('120 Minute');
                      } else if (head == '120 Minute' &&
                          languageProvider.locale.toString() == 'tr') {
                        predictionProvider.setHead('120 Dakika');
                      }
                      //context.read<PredictionProvider>().setHead(e!);
                    },
                    items: L10n.all
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(title2(e.languageCode)),
                            ))
                        .toList())),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: () async {
                context.read<BottomNavBarProvider>().onItemTapped(0);
                context.read<AppBarProvider>().setTitle(0, context);
                var loginProvider =
                    Provider.of<LoginPageProvider>(context, listen: false);
                if (loginProvider.isLogin!) {
                  await GoogleSignIn().signOut();
                } else {
                  auth.signOut();
                }

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
            )
          ],
          backgroundColor: const Color(0xff3AB4F2),
          title: Text(
            pageIndex.toString() == '0'
                ? AppLocalizations.of(context)!.tracking_page
                : pageIndex == 1
                    ? AppLocalizations.of(context)!.trainingGuide
                    : pageIndex == 2
                        ? AppLocalizations.of(context)!.diagnose
                        : pageIndex == 3
                            ? AppLocalizations.of(context)!.prediction_page
                            : pageIndex == 4
                                ? AppLocalizations.of(context)!.alarm_page
                                : AppLocalizations.of(context)!.tracking_page,
            style: const TextStyle(color: Colors.white),
          )),
      body: SafeArea(child: selectPage(pageIndex)),
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _displayTextInputDialog(context);
              },
              backgroundColor: const Color(0xff3AB4F2),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
