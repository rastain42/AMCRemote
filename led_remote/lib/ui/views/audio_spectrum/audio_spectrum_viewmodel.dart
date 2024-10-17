import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:record/record.dart';
import 'package:fftea/fftea.dart';
import 'package:fl_chart/fl_chart.dart';

class AudioSpectrumViewModel extends BaseViewModel {
  final AudioRecorder _recorder = AudioRecorder();
  List<double> _spectrumData = List.filled(50, 0.0);
  Timer? _timer;
  bool isRecording = false;

  // Méthode pour démarrer l'enregistrement
  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      await _recorder.start(
        RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: '',
      );

      isRecording = true;
      notifyListeners();

      _timer = Timer.periodic(Duration(milliseconds: 100), _updateSpectrumData);
    }
  }

  // Méthode pour arrêter l'enregistrement
  Future<void> stopRecording() async {
    await _recorder.stop();
    _timer?.cancel();
    isRecording = false;
    notifyListeners();
  }

  // Méthode pour générer des données FFT
  void _updateSpectrumData(Timer timer) async {
    final audioAmplitude = await _recorder.getAmplitude();
    if (audioAmplitude != null) {
      // Simuler la conversion de l'amplitude en échantillons audio
      List<double> audioSamples = List.generate(
          512, (index) => audioAmplitude.current * Random().nextDouble());

      // Appliquer la FFT sur les échantillons audio
      var fft = FFT(512);
      Float64x2List fftResult = fft.realFft(audioSamples);

      // Extraire les 50 premières fréquences (partie réelle)
      _spectrumData = fftResult
          .take(50)
          .map((complex) => complex.x.abs())
          .toList(); // complex.x est la partie réelle
      notifyListeners();
    }
  }

  // Générer les groupes de barres pour le BarChart
  List<BarChartGroupData> getBarChartGroups() {
    return _spectrumData
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                width: 5,
                color: Colors.blueAccent,
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
