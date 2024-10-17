import 'package:flutter/material.dart';
import 'package:led_remote/ui/views/audio_spectrum/audio_spectrum_view.dart';
import 'package:led_remote/ui/views/message/message_view.dart';
import 'package:led_remote/ui/views/temperature/temperature_view.dart';
import 'package:led_remote/ui/views/time/time_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;
  final List<Widget> pages = [
    TimeView(),
    TemperatureView(),
    MessageView(),
    AudioSpectrumView(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
  }
}
