import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'audio_spectrum_viewmodel.dart';

class AudioSpectrumView extends StackedView<AudioSpectrumViewModel> {
  const AudioSpectrumView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AudioSpectrumViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spectre Audio en Temps Réel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isRecording
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 100, // Maximum value for the y-axis
                      barGroups: _buildSpectrumBars(),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                )
              : Text("Clique sur Démarrer pour capturer l'audio"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isRecording ? _stopRecording : _startRecording,
            child: Text(isRecording ? 'Arrêter' : 'Démarrer l\'enregistrement'),
          ),
        ],
      ),
    );
  }

  @override
  AudioSpectrumViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AudioSpectrumViewModel();
}
