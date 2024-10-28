import 'package:amc_remote/app/app.bottomsheets.dart';
import 'package:amc_remote/app/app.dialogs.dart';
import 'package:amc_remote/app/app.locator.dart';
import 'package:amc_remote/app/app.router.dart';
import 'package:amc_remote/ui/common/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signOut() async {
    await _auth.signOut();
    _navigationService.navigateTo(Routes.loginView);
  }
}
