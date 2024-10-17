import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'audio_spectrum_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';
import 'audio_spectrum_viewmodel.dart';

class AudioSpectrumView extends StackedView<AudioSpectrumViewModel> {
  const AudioSpectrumView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AudioSpectrumViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<AudioSpectrumViewModel>.reactive(
      viewModelBuilder: () => AudioSpectrumViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Spectre Audio en Temps Réel'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            model.isRecording
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BarChart(
                      BarChartData(
                        maxY: 100,
                        barGroups: model.getBarChartGroups(),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  )
                : Text("Cliquez sur Démarrer pour capturer l'audio"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: model.isRecording
                  ? model.stopRecording
                  : model.startRecording,
              child: Text(
                  model.isRecording ? 'Arrêter' : 'Démarrer l\'enregistrement'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AudioSpectrumViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AudioSpectrumViewModel();
}
