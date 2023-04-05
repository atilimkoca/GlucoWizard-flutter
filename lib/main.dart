import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/l10n/l10.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';
import 'package:glucowizard_flutter/providers/health_page_provider.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'services/locale_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glucowizard_flutter/views/home_page.dart';

import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
    ChangeNotifierProvider(create: (_) => HealtPageProvider()),
    ChangeNotifierProvider(create: (_) => AppBarProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // translations: LocaleStrings(),
      locale: context.watch<LanguageProvider>().locale ?? const Locale('tr'),
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
      home: const HomePage(),
    );
  }
}
