import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jak_sie_masz/Data/services/database_helper_service.dart';
import 'package:jak_sie_masz/Data/repositories/day_rating_repository.dart';
import 'package:jak_sie_masz/Data/repositories/exercise_data_repository.dart';
import 'package:jak_sie_masz/Data/services/navigation_service.dart';
import 'package:jak_sie_masz/Data/services/notification_service.dart';
import 'package:jak_sie_masz/Data/repositories/rate_slider_repository.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/articles_viewmodel.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_chart_viewmodel.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_picture_dialog_viewmodel.dart';
import 'package:jak_sie_masz/UI/Profile/viewmodels/profile_viewmodel.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/viewmodels/navigation_viewmodel.dart';
import 'package:provider/provider.dart';
import 'routing/router.dart';
import 'package:jak_sie_masz/UI/AIChat/services/chat_service.dart';
import 'package:jak_sie_masz/UI/AIChat/services/chat_database_service.dart';
import 'package:jak_sie_masz/UI/AIChat/viewmodels/aichat_viewmodel.dart';

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
          create: (context) => NavigationViewmodel(
            context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewmodel(
            context.read(),
            context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RateSliderViewmodel(
            rateSliderRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RateChartViewmodel(
            databaseHelperService: context.read(),
            dayRatingRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ExercisesViewModel(
            repository: ExerciseDataRepository(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => ArticlesViewmodel()),
        Provider(
          create: (context) => ChatService(),
        ),
        Provider(
          create: (context) => ChatDatabaseService(
            context.read<DatabaseHelperService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AIChatViewModel(
              context.read<ChatService>(), context.read<ChatDatabaseService>())
            ..initialize(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticlesViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilePictureDialogViewmodel(
            userRepository: context.read(),
          ),
        )
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
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
        );
      },
    );
  }
}
