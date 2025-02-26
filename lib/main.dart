import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/navigation_service.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/viewmodels/navigation_viewmodel.dart';
import 'package:provider/provider.dart';
import 'routing/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => RateSliderRepository(),
        ),
        Provider(
          create: (context) => UserRepository(),
        ),
        Provider(
          create: (context) => NavigationService(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationViewmodel(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RateSliderViewmodel(rateSliderRepository: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => ExercisesViewModel(),
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
