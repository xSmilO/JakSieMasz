import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jak_sie_masz/Data/database_helper_service.dart';
import 'package:jak_sie_masz/Data/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/navigation_service.dart';
import 'package:jak_sie_masz/Data/notification_service.dart';
import 'package:jak_sie_masz/Data/rate_slider_repository.dart';
import 'package:jak_sie_masz/Data/shared_preferences_service.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/articles_viewmodel.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_chart_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/viewmodels/navigation_viewmodel.dart';
import 'package:provider/provider.dart';
import 'routing/router.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  NotificationService().initNotification();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => SharedPreferencesService()),
        Provider(
          create: (context) => DatabaseHelperService(),
        ),
        Provider(
          create: (context) => RateSliderRepository(),
        ),
        Provider(
          create: (context) => DayRatingRepository(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => UserRepository(context.read()),
        ),
        Provider(
          create: (context) => NavigationService(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationViewmodel(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(context.read(), context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RateSliderViewmodel(rateSliderRepository: context.read()),
        ),
        ChangeNotifierProvider(
            create: (context) => RateChartViewmodel(
                databaseHelperService: context.read(),
                dayRatingRepository: context.read())),
        ChangeNotifierProvider(
          create: (context) => ExercisesViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => ArticlesViewmodel())
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
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteColor: Styles.primaryColor500,
          dialTextColor: Colors.white,
          dialBackgroundColor: Styles.primaryColor500,
          dialTextStyle: TextStyle(
            fontFamily: Styles.fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          hourMinuteTextColor: Colors.white,
          dialHandColor: Styles.primaryColor300,
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Styles.primaryColor500),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Styles.secondaryColor300),
          ),
        ),
      ),
      routerConfig: router(),
    );
  }
}
