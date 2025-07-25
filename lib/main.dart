

import 'package:e_learning/components/connectivity_listener.dart';
import 'package:e_learning/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {

  runApp(ProviderScope(child: MyApp()));
  await GetStorage.init('user');
  await GetStorage.init('registered');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ConnectivityListener(
          child: SplashView(),
        ),
      ),
    );
  }
}


