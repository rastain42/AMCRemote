import 'package:flutter/material.dart';
import 'package:ledRemote/app/app.bottomsheets.dart';
import 'package:ledRemote/app/app.dialogs.dart';
import 'package:ledRemote/app/app.locator.dart';
import 'package:ledRemote/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    TimeView(),
    TemperatureView(),
    MessageView(),
    AudioSpectrumView(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }
}
