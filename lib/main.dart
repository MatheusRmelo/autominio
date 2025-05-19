import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'core/themes/theme_light.dart';
import 'injection_container.dart';
import 'router_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await initializeDateFormatting();
  Intl.defaultLocale = 'pt_BR';
  //await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InjectionContainer injection;

  @override
  void initState() {
    super.initState();
    injection = InjectionContainer();
    injection.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeLight.themeData,
      routerConfig: RouterContainer.getRoutes,
    );
  }
}
