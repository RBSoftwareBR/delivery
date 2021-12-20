import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicrophoneDialog extends StatefulWidget {
  const MicrophoneDialog({Key? key}) : super(key: key);

  @override
  _MicrophoneDialogState createState() {
    return _MicrophoneDialogState();
  }
}

class _MicrophoneDialogState extends State<MicrophoneDialog> {
  @override 
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    Future.delayed(const Duration(milliseconds: 500)).then((v){
      _listen();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child:
    AvatarGlow(
      animate: _isListening,
      glowColor: Theme.of(context).primaryColor,
      endRadius: 75.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      child: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    ));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        // ignore: avoid_print
        onStatus: (val) => print('onStatus: $val'),
        // ignore: avoid_print
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
            }
          }),
        );
        Future.delayed(const Duration(seconds:5)).then((v){
          _speech!.stop();
          Navigator.of(context).pop(_text);
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }
}