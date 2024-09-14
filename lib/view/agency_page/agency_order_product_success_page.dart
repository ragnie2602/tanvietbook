import 'package:flutter/material.dart';

import '../../data/resources/resources.dart';
import '../../shared/widgets/primary_app_bar.dart';

class AgencyOrderProductSuccessPage extends StatelessWidget {
  const AgencyOrderProductSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFfeeb9b),
        appBar: const PrimaryAppBar(
          backgroundColor: Color(0xFFfeeb9b),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Image.asset(Assets.imOrderSuccess),
        ));
  }
}
