import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/resources/colors.dart';
import 'component/web_mini_overall.dart';

import '../bloc/business_bloc.dart';

class BusinessOverallPage extends StatelessWidget {
  BusinessOverallPage({Key? key}) : super(key: key);
  final BusinessBloc businessBloc = BusinessBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => businessBloc..add(BusinessGetAllEvent()),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  WebMiniOverall(
                    businessBloc: businessBloc,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
