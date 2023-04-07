import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/components/bottom_navbar.dart';
import 'package:glucowizard_flutter/l10n/l10.dart';

import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:glucowizard_flutter/providers/prediction_provider.dart';
import 'package:glucowizard_flutter/views/alarms_page.dart';
import 'package:glucowizard_flutter/views/diagnose_page.dart';
import 'package:glucowizard_flutter/views/prediction_page.dart';
import 'package:glucowizard_flutter/views/tracking_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/language_provider.dart';

import 'health_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    var lang = languageProvider.locale ?? const Locale('tr');
    var title = context.watch<AppBarProvider>().title;
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
      backgroundColor: Color.fromARGB(255, 245, 239, 245),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton2(
                    style: TextStyle(
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
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
