import 'package:stacked/stacked.dart';

class MessageViewModel extends BaseViewModel {
  void sendMessage(String message) {
    // Logic to send the message to the LED matrix
    print('Message sent to matrix: $message');
  }
}
