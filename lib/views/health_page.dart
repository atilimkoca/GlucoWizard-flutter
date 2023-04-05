import 'package:flutter/material.dart';

import '../components/health_gridview.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HealthGridView(),
    );
  }
}
