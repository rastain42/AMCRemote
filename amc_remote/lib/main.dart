import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:amc_remote/app/app.bottomsheets.dart';
import 'package:amc_remote/app/app.dialogs.dart';
import 'package:amc_remote/app/app.locator.dart';
import 'package:amc_remote/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMC Remote',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.loginView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
