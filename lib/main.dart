import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:jak_sie_masz/UI/Profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import 'routing/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => RateSliderRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RateSliderViewmodel(rateSliderRepository: context.read()),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: Styles.fontFamily,
      ),
      routerConfig: router(),
    );
  }
}
