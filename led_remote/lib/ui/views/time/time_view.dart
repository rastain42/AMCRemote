import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'time_viewmodel.dart';

class TimeView extends StackedView<TimeViewModel> {
  const TimeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TimeViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<TimeViewModel>.reactive(
      viewModelBuilder: () => TimeViewModel(),
      builder: (context, model, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Envoyer l\'heure actuelle à la matrice LED'),
            ElevatedButton(
              onPressed: () => model.sendTime(),
              child: Text('Envoyer l\'heure'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TimeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimeViewModel();
}
