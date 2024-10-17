import 'package:flutter/material.dart';
import 'package:led_remote/app/app.bottomsheets.dart';
import 'package:led_remote/app/app.dialogs.dart';
import 'package:led_remote/app/app.locator.dart';
import 'package:led_remote/app/app.router.dart';
import 'package:led_remote/ui/views/authentification/authentification_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';

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
      title: 'LED Matrix Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      home: AuthentificationView(),
    );
  }
}
