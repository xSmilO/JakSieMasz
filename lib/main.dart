import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import 'routing/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
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
      routerConfig: router(),
    );
  }
}
