import 'package:amc_remote/app/app.locator.dart';
import 'package:amc_remote/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signIn(String email, String password) async {
    setBusy(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _navigationService.navigateTo(Routes.homeView);
    } catch (e) {
      print("Erreur de connexion : $e");
    } finally {
      setBusy(false);
    }
  }
}
