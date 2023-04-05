import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarProvider extends ChangeNotifier {
  String? _title = 'Takip Çizelgesi';
  String get title => _title!;
  setTitle(int index, BuildContext context) {
    switch (index) {
      case 0:
        _title = AppLocalizations.of(context)!.tracking_page;

        break;
      case 1:
        _title = 'Sağlık Kataloğu';
        break;
      case 2:
        _title = 'Kan Şekeri Tahmini';
        break;
      default:
        _title = 'Teşhis';
        break;
    }

    notifyListeners();
  }
}
