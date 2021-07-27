//**************************************************************
// Home view model
// Author: Christian Ahmed
//**************************************************************
import 'package:memory_enhancer_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel with WidgetsBindingObserver {
  String recognizedWords = '';
  String _triggers = '';

  // Boolean storing value whether the speech engine is listening or not
  bool get listening {
    return speechService.isListening;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        //speechService.listenForWakeWord(); AHMED
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        //speechService.stopListeningForWakeWord(); AHMED
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }

    notifyListeners();
  }

  void initialize() {
    WidgetsBinding.instance?.addObserver(this);
  }

  Future<void> startListening() async {
    // If already listening, stop listening
    if (listening) {
      speechService.stopListening();
    }
    // else start listening
    else {
      speechService.startListening();
      notifyListeners();

      /*
      speechService.startListening(resultCallback: (result) async {
        if (result.recognizedWords.isNotEmpty) {
          recognizedWords = result.recognizedWords;

          startRecord(result); // Record if trigger is heard

          notifyListeners();
        }
      });
       */


    }
    notifyListeners();
  }

  // TODO : Ahmed - revisit
  /*
  // Start recording new note if trigger is heard.
  void startRecord(SpeechRecognitionResult result) async {
    // record notes
    String keywords = await fileOperations.readTriggers(0);
    _triggers = keywords;

    if (!speechService.isListening && result.finalResult) {
      fileOperations.recordNotes(
          _triggers, speechService.interimTranscript);
    }
  } // End record notes

   */

  @override
  void dispose() {
    //speechService.stopListeningForWakeWord(); AHMED
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [speechService];
}
