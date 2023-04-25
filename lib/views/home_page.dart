import 'dart:io';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:glucowizard_flutter/components/bottom_navbar.dart';
import 'package:glucowizard_flutter/l10n/l10.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';

import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/prediction_provider.dart';
import 'package:glucowizard_flutter/providers/profile_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';

import 'package:glucowizard_flutter/views/alarms_page.dart';
import 'package:glucowizard_flutter/views/diagnose_page.dart';
import 'package:glucowizard_flutter/views/login_page.dart';
import 'package:glucowizard_flutter/views/prediction_page.dart';
import 'package:glucowizard_flutter/views/profile_page.dart';

import 'package:glucowizard_flutter/views/tracking_page.dart';
import 'package:glucowizard_flutter/views/type2_prediction.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/language_provider.dart';

import 'alarm.dart';
import 'health_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var loginPageProvider = Provider.of<LoginPageProvider>(context);
    Time _time = Time(hour: 11, minute: 30, second: 20);

    var trackingChartProvider =
        Provider.of<TrackingChartProvider>(context, listen: true);
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    TextEditingController popupController = TextEditingController();
    var lang =
        languageProvider.locale ?? Locale(Platform.localeName.split('_')[0]);
    var currentDate = trackingChartProvider.currentDate ?? DateTime.now();

    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(5),
                  title: Text(AppLocalizations.of(context)!.new_record),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => newValue.copyWith(
                          text: newValue.text.replaceAll(',', '.'),
                        ),
                      ),
                    ],
                    controller: popupController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText:
                          AppLocalizations.of(context)!.enterGlucoseValue,
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
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
                                      cancelText:
                                          AppLocalizations.of(context)!.cancel,
                                      okText:
                                          AppLocalizations.of(context)!.okay,
                                      value: _time,
                                      onChange: (time) {},
                                      onChangeDateTime: (p0) {
                                        var dateNow = DateTime.now();
                                        print(dateNow);
                                        var stringDate = p0.toString();
                                        const dateTimeString =
                                            '2020-07-17T03:18:31.177769-04:00';
                                        final dateTime = DateTime.parse(
                                            stringDate.replaceFirst(
                                                RegExp(r'-\d\d:\d\d'), ''));

                                        final format = DateFormat.Hm();
                                        // final clockString =
                                        //     format.format(dateTime);
                                        // var testTime = DateTime.parse(
                                        //     '${currentDate}T$clockString');
                                        // print(
                                        //     format.format(testTime)); // 03:18 AM
                                        var formatter = DateFormat.Hm();
                                        // if (languageProvider.locale.toString() ==
                                        //     'tr_TR') {
                                        //   formatter = DateFormat.Hm();
                                        // } else {
                                        //   formatter = DateFormat.jm();
                                        // }

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
                              Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: Text(
                                    AppLocalizations.of(context)!.current_time),
                              )
                            ],
                          ),
                          MaterialButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text(AppLocalizations.of(context)!.okay),
                            onPressed: () {
                              // var date = DateTime.now();
                              // var formatter = DateFormat('yyyy-MM-dd');
                              //String formattedDate = formatter.format(date);

                              var currentDate =
                                  trackingChartProvider.currentDate;
                              var currentHour =
                                  trackingChartProvider.currentHour;
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
      var loginPageProvider = Provider.of<LoginPageProvider>(context);
      if (loginPageProvider.offline) {
        switch (pageIndex) {
          case 0:
            return HealthPage();

          case 1:
            return DiagnosePage();
          case 2:
            return PredictionPage();
          case 3:
            return const TypetwoPredictionPage();

          default:
            return DiagnosePage();
        }
      } else {
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
            return TypetwoPredictionPage();
          case 5:
            return Alarm();
          case 6:
            return ProfilePage();
          default:
            return DiagnosePage();
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xffe8dff6),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('assets/images/world.png'))),
                  child: DropdownButton2(

                      //buttonStyleData: ButtonStyleData(),
                      //customButton: Image.asset('assets/images/logout.png'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //overflow: TextOverflow.ellipsis,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color.fromARGB(255, 142, 97, 209),
                          ),
                          elevation: 8,
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          LineIcons.globe,
                          size: 20,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                      ),
                      value: lang,
                      onChanged: (Locale? val) {
                        context.read<LanguageProvider>().setLocale(val!);
                        var predictionProvider =
                            Provider.of<PredictionProvider>(context,
                                listen: false);
                        var profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);
                        var head = predictionProvider.head;
                        var head2 = predictionProvider.head2;
                        var gender = profileProvider.gender;
                        if (gender == 'Erkek' &&
                            languageProvider.locale.toString() == 'en') {
                          profileProvider.setGender('Male');
                        } else if (gender == 'Male' &&
                            languageProvider.locale.toString() == 'tr') {
                          profileProvider.setGender('Erkek');
                        } else if (gender == 'Female' &&
                            languageProvider.locale.toString() == 'tr') {
                          profileProvider.setGender('Kadın');
                        } else if (gender == 'Kadın' &&
                            languageProvider.locale.toString() == 'en') {
                          profileProvider.setGender('Female');
                        }
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
                        if (head2 == '15 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('15 Minute');
                        } else if (head2 == '15 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('15 Dakika');
                        } else if (head2 == '30 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('30 Minute');
                        } else if (head2 == '30 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('30 Dakika');
                        } else if (head2 == '45 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('45 Minute');
                        } else if (head2 == '45 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('45 Dakika');
                        } else if (head2 == '60 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('60 Minute');
                        } else if (head2 == '60 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('60 Dakika');
                        } else if (head2 == '90 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('90 Minute');
                        } else if (head2 == '90 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('90 Dakika');
                        } else if (head2 == '120 Dakika' &&
                            languageProvider.locale.toString() == 'en') {
                          predictionProvider.setHead2('120 Minute');
                        } else if (head2 == '120 Minute' &&
                            languageProvider.locale.toString() == 'tr') {
                          predictionProvider.setHead2('120 Dakika');
                        }
                      },
                      items: L10n.all
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(title2(e.languageCode)),
                              ))
                          .toList()),
                )),

            GestureDetector(
              onTap: () async {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            )
            // IconButton(
            //   icon: const Icon(Icons.logout),
            //   color: Colors.white,
            //   onPressed: () async {
            //     context.read<BottomNavBarProvider>().onItemTapped(0);
            //     context.read<AppBarProvider>().setTitle(0, context);
            //     var loginProvider =
            //         Provider.of<LoginPageProvider>(context, listen: false);
            //     if (loginProvider.isLogin!) {
            //       await GoogleSignIn().signOut();
            //     } else {
            //       auth.signOut();
            //     }

            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => const LoginPage()),
            //         (route) => false);
            //   },
            // )
          ],
          backgroundColor: Color.fromARGB(255, 142, 97, 209),
          title: Text(
            loginPageProvider.offline == false
                ? pageIndex.toString() == '0'
                    ? AppLocalizations.of(context)!.tracking_page
                    : pageIndex == 1
                        ? AppLocalizations.of(context)!.trainingGuide
                        : pageIndex == 2
                            ? AppLocalizations.of(context)!.diagnose
                            : pageIndex == 3
                                ? AppLocalizations.of(context)!.type1_prediction
                                : pageIndex == 4
                                    ? AppLocalizations.of(context)!
                                        .type2_prediction
                                    : pageIndex == 5
                                        ? AppLocalizations.of(context)!
                                            .alarm_page
                                        : pageIndex == 6
                                            ? AppLocalizations.of(context)!
                                                .profile_page
                                            : AppLocalizations.of(context)!
                                                .tracking_page
                : pageIndex.toString() == '0'
                    ? AppLocalizations.of(context)!.trainingGuide
                    : pageIndex == 1
                        ? AppLocalizations.of(context)!.diagnose
                        : pageIndex == 2
                            ? AppLocalizations.of(context)!.type1_prediction
                            : pageIndex == 3
                                ? AppLocalizations.of(context)!.type2_prediction
                                : AppLocalizations.of(context)!.trainingGuide,
            style: const TextStyle(color: Colors.white),
          )),
      body: SafeArea(child: selectPage(pageIndex)),
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _displayTextInputDialog(context);
              },
              backgroundColor: const Color(0xff9971d6),
              child: const Icon(
                LineIcons.calendarPlus,
                color: Colors.white,
                size: 35,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
