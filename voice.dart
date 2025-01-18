import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechRecognitionPage(),
    );
  }
}

class SpeechRecognitionPage extends StatefulWidget {
  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _recognizedText = "Press the button and start speaking...";

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  // Function to start/stop voice recognition
  void _toggleListening() async {
    if (_isListening) {
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();
    } else {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _recognizedText = "Listening...";
        });
        _speechToText.listen(onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        });
      } else {
        setState(() {
          _recognizedText = "Speech recognition is not available.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dart Voice Recognition")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _recognizedText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleListening,
              child: Text(_isListening ? "Stop Listening" : "Start Listening"),
            ),
          ],
        ),
      ),
    );
  }
}
