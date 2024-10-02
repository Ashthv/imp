import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';

class TextToSpeech {
  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  bool get _isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  TextToSpeech() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (_isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
  }

  void setStartHandler(final VoidCallback callback) {
    ttsState = TtsState.playing;
    flutterTts.setStartHandler(callback);
  }

  void setCompletionHandler(final VoidCallback callback) {
    ttsState = TtsState.stopped;
    flutterTts.setCompletionHandler(callback);
  }

  void setCancelHandler(final VoidCallback callback) {
    ttsState = TtsState.stopped;
    flutterTts.setCancelHandler(callback);
  }

  void setPauseHandler(final VoidCallback callback) {
    ttsState = TtsState.paused;
    flutterTts.setPauseHandler(callback);
  }

  void setContinueHandler(final VoidCallback callback) {
    ttsState = TtsState.continued;
    flutterTts.setContinueHandler(callback);
  }

  void setErrorHandler(
    final void Function(dynamic) handler,
    final String message,
  ) {
    ConsoleLogger().log('TTS error handler: $message');
    ttsState = TtsState.stopped;
    flutterTts.setErrorHandler(handler);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _getDefaultEngine() async {
    await flutterTts.getDefaultEngine;
  }

  Future<void> _getDefaultVoice() async {
    await flutterTts.getDefaultVoice;
  }

  Future<dynamic> getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> getEngines() async => await flutterTts.getEngines;

  Future<dynamic> setEngine(final String engine) async {
    this.engine = engine;
    await flutterTts.setEngine(engine);
  }

  Future<dynamic> setLanguage(final String language) async {
    this.language = language;
    await flutterTts.setLanguage(language);
  }

  /// [Future] which invokes the platform specific method for setVolume.
  /// Allowed values are in the range from 0.0 (silent) to 1.0 (loudest)
  Future<dynamic> setVolume(final double volume) async {
    if (volume >= 0.0 && volume <= 1.0) {
      this.volume = volume;
      await flutterTts.setVolume(volume);
    }
  }

  /// [Future] which invokes the platform specific method for setSpeechRate.
  /// Allowed values are in the range from 0.0 (slowest) to 1.0 (fastest)
  Future<dynamic> setSpeechRate(final double rate) async {
    if (volume >= 0.0 && volume <= 1.0) {
      this.rate = rate;
      await flutterTts.setSpeechRate(rate);
    }
  }

  /// [Future] which invokes the platform specific method for
  /// setPitch 1.0 is default and ranges from .5 to 2.0
  Future<dynamic> setPitch(final double pitch) async {
    if (volume >= 0.5 && volume <= 2.0) {
      this.pitch = pitch;
      await flutterTts.setPitch(pitch);
    }
  }

  Future<void> speak(final String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    final htmlStripedText = _stripHtmlTags(text);

    final list = await _getCharLimitList(htmlStripedText);

    for (final textElement in list) {
      if (textElement.isNotEmpty) {
        await flutterTts.speak(textElement);
      }
    }
  }

  Future<void> stop() async {
    final result = await flutterTts.stop();
    if (result == 1) {
      ttsState = TtsState.stopped;
    }
  }

  Future<void> pause() async {
    final result = await flutterTts.pause();
    if (result == 1) {
      ttsState = TtsState.paused;
    }
  }

  Future<dynamic> synthesizeToFile(
    final String text,
    final String fileName,
  ) async {
    final list = await _getCharLimitList(text);
    var count = 1;

    for (final textElement in list) {
      if (textElement.isNotEmpty) {
        await flutterTts.synthesizeToFile(
          textElement,
          '${count.toString()}_$fileName',
        );
        count++;
      }
    }
  }

  Future<List<String>> _getCharLimitList(final String text) async {
    if (_isAndroid) {
      final charLimit = await flutterTts.getMaxSpeechInputLength;
      if (charLimit != null && text.length > charLimit - 5) {
        final result = <String>[];
        final words = text.split(' ');
        final currentLine = StringBuffer();

        for (final word in words) {
          if (currentLine.length + word.length + 1 <= charLimit - 5) {
            if (currentLine.isNotEmpty) {
              currentLine.write(' ');
            }
            currentLine.write(word);
          } else {
            result.add(currentLine.toString());
            currentLine
              ..clear()
              ..write(word);
          }
        }
        if (currentLine.isNotEmpty) {
          result.add(currentLine.toString());
        }
        return result;
      }
    }
    return [text];
  }

  String _stripHtmlTags(final String text) {
    final exp = RegExp(
      r'<[^>]*>',
      multiLine: true,
    );
    return text.replaceAll(exp, '');
  }
}

enum TtsState { playing, stopped, paused, continued }
