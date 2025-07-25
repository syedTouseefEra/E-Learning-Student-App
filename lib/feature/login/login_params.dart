

import 'package:flutter/material.dart';

class LoginParams {
  final String mobileNo;
  final String password;
  final BuildContext context;

  LoginParams({
    required this.mobileNo,
    required this.password,
    required this.context,
  });
}
