



import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/dashboard/dashboard_data_model.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final List<DashboardDataModel> data;

  const DashboardView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final dashboardItem = data[index];
        return ListTile(
          title: CustomText(text: dashboardItem.name.toString()),
          subtitle: CustomText(text: dashboardItem.token.toString()),
        );
      },
    );
  }
}
