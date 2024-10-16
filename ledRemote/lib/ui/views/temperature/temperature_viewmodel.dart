import 'package:stacked/stacked.dart';

class TemperatureViewModel extends BaseViewModel {
  void sendTemperature(String temperature) {
    // Logic to send the temperature to the LED matrix
    print('Temperature sent to matrix: $temperature');
  }
}
