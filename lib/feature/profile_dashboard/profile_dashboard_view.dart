

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileDashboard extends HookConsumerWidget{
  const ProfileDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blue,
      child: Text("ProfileDashboard"),
    );
  }

}