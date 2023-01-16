import 'package:flutter/material.dart';

import 'app_resources/routes_manager.dart';
import 'app_resources/string_resources.dart';
import 'app_resources/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initRoute,
      onGenerateRoute: RoutesGenerator.getRoutes,
      title: AppString.app_title,
      theme: getApplicationTheme(),
    );
  }
}


