import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glucowizard_flutter/firebase_options.dart';
import 'package:glucowizard_flutter/l10n/l10.dart';
import 'package:glucowizard_flutter/providers/alarms_provider.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:glucowizard_flutter/providers/health_page_provider.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/prediction_provider.dart';
import 'package:glucowizard_flutter/providers/profile_provider.dart';
import 'package:glucowizard_flutter/providers/register_provider.dart';
import 'package:glucowizard_flutter/providers/reminder_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';
import 'package:glucowizard_flutter/services/notification.dart';

import 'package:glucowizard_flutter/views/login_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initalizeNotification();
  await AndroidAlarmManager.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
    ChangeNotifierProvider(create: (_) => HealtPageProvider()),
    ChangeNotifierProvider(create: (_) => AppBarProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => PredictionProvider()),
    ChangeNotifierProvider(create: (_) => LoginPageProvider()),
    ChangeNotifierProvider(create: (_) => TrackingChartProvider()),
    ChangeNotifierProvider(create: (_) => RegisterPageProvider()),
    ChangeNotifierProvider(create: (_) => AlarmsProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => ReminderProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // translations: LocaleStrings(),

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: const LoginPage(),
      locale: context.watch<LanguageProvider>().locale ??
          Locale(Platform.localeName.split('_')[0]),
    );
  }
}
