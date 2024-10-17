import 'package:led_remote/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      NavigationService().navigateTo(Routes.homeView);
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }
}
