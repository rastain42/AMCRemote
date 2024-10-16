import 'package:stacked/stacked.dart';

class AudioSpectrumViewModel extends BaseViewModel {
  bool isRecording = false;
  FlutterAudioRecorder? _recorder;

  Future<void> startRecording() async {
    isRecording = true;
    notifyListeners();
    _recorder = FlutterAudioRecorder('audio_spectrum');
    await _recorder!.initialized;
    await _recorder!.start();
  }

  FlutterAudioRecorder? _recorder;
  Timer? _timer;
  bool isRecording = false;
  List<double> _spectrumData =
      List.filled(50, 0.0); // Spectrum data initialized

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  // Initialize the audio recorder
  Future<void> _initializeRecorder() async {
    _recorder = FlutterAudioRecorder('audio_spectrum');
    await _recorder!.initialized;
  }

  // Start recording and update the spectrum data
  Future<void> _startRecording() async {
    await _recorder!.start();
    isRecording = true;
    _timer = Timer.periodic(Duration(milliseconds: 100), _updateSpectrumData);
    setState(() {});
  }

  // Stop recording
  Future<void> _stopRecording() async {
    var result = await _recorder!.stop();
    isRecording = false;
    _timer?.cancel();
    setState(() {});
  }

  // Simulate updating spectrum data (for demonstration purposes)
  void _updateSpectrumData(Timer timer) {
    setState(() {
      _spectrumData = List.generate(
          50, (index) => Random().nextDouble() * 100); // Random data
    });
  }

  // Generate the bar chart for the audio spectrum
  List<BarChartGroupData> _buildSpectrumBars() {
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
}
