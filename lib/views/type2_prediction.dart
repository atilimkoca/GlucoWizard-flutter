import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/components/prediction_textfields.dart';

import '../components/prediction_textfield_2.dart';

class TypetwoPredictionPage extends StatelessWidget {
  const TypetwoPredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PredictionTextFieldsTwo(
        title: 'test',
      ),
    );
  }
}
