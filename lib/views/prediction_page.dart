import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/components/prediction_textfields.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PredictionTextFields(
        title: 'test',
      ),
    );
  }
}
