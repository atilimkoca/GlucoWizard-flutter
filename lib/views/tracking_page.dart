import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/providers/appbar_provider.dart';
import 'package:glucowizard_flutter/providers/bottom_navbar_provider.dart';

import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../providers/language_provider.dart';
import '../services/languages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrackingPage extends StatelessWidget {
  TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.tracking_page),
          ElevatedButton(onPressed: () {}, child: const Text('en')),
          ElevatedButton(onPressed: () {}, child: const Text('tr')),
        ],
      ),
    );
  }
}
