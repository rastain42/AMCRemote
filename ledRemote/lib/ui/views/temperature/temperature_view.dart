import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'temperature_viewmodel.dart';

class TemperatureView extends StackedView<TemperatureViewModel> {
  TemperatureView({Key? key}) : super(key: key);

  final _temperatureController = TextEditingController();

  @override
  Widget builder(
    BuildContext context,
    TemperatureViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<TemperatureViewModel>.reactive(
      viewModelBuilder: () => TemperatureViewModel(),
      builder: (context, model, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Envoyer la température à la matrice LED'),
            TextField(
              controller: _temperatureController,
              decoration: InputDecoration(labelText: 'Température'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () =>
                  model.sendTemperature(_temperatureController.text),
              child: Text('Envoyer la température'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TemperatureViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TemperatureViewModel();
}
