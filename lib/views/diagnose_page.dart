import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/components/diagnose_top.dart';

import '../components/diagnose_card.dart';

class DiagnosePage extends StatelessWidget {
  DiagnosePage({super.key});
  final glucoseController = TextEditingController();
  final insulinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        DiagnoseTop(),
        DiagnoseCard(
          glucoseController: glucoseController,
          insulinController: insulinController,
        )
      ]),
    );
  }
}
