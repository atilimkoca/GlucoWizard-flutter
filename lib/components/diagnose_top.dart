import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiagnoseTop extends StatelessWidget {
  const DiagnoseTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Lottie.asset('assets/images/diagnose.json',
            height: MediaQuery.of(context).size.height * 0.18),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(AppLocalizations.of(context)!.diagnose_text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      )
    ]);
  }
}
