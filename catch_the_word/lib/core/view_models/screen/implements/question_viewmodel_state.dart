import 'dart:typed_data';

import 'package:audio_helper/audio_helper.dart';
import 'package:catch_the_word/core/firebase/interfaces/ifirebase_message.dart';
import 'package:catch_the_word/core/global/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import '../../../model_ui/cross_word_model_ui.dart';
import '../interfaces/iquestion_viewmodel.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:better_sound_effect/better_sound_effect.dart';

class QuestionViewModel extends ChangeNotifier implements IQuestionViewModel {
  final FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  final String _correctSoundPath = 'sounds/correct.mp3';
  final String _failSoundPath = 'sounds/fail.mp3';
  //AudioPlayer advancedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  AudioCache audioCache = AudioCache();
  final soundEffect = BetterSoundEffect();
  late int? correctSoundId;
  late int? failedSoundId;
  late String _groupId;
  late String _messageId;
  IFirebaseMessageService _iFirebaseMessageService =
      locator<IFirebaseMessageService>();
  @override
  int get correctAnswerLength => correctAnswer.length;

  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final Random _rnd = Random();
  static String _correctAnswer = '';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  final List<CrossWordModelUI> _answer = [];
  @override
  List<CrossWordModelUI> get answer => _answer;

  List<CrossWordModelUI> _keyboardAnswer = [];

  @override
  String get correctAnswer => _correctAnswer;

  @override
  List<CrossWordModelUI> get keyboardAnswer => _keyboardAnswer;

  @override
  void selectCrossWord(String id) {
    if (_answer.length < correctAnswer.length) {
      var crossWord = _keyboardAnswer.firstWhere((element) => element.id == id);
      crossWord.isSelected = true;
      _answer.add(crossWord);
      notifyListeners();
    }
    _checkCorrect();
  }

  Future<void> _checkCorrect() async {
    if (_answer.length == correctAnswer.length) {
      AudioHelper.stopMusic();
      String answerTemp = '';
      for (var x in _answer) {
        answerTemp += x.value;
      }
      if (correctAnswer == answerTemp) {
        Get.dialog(
            Container(
              color: Colors.transparent,
              child: Image.asset('assets/images/bingo.png'),
            ),
            transitionDuration: const Duration(seconds: 1),
            transitionCurve: Curves.easeInOutCirc);
        await soundEffect.play(correctSoundId!);
        await _iFirebaseMessageService.updateMessage(_groupId, _messageId);
        await Future.delayed(const Duration(seconds: 5), () {
          Get.back();
          Get.back();
        });
      } else {
        Get.dialog(
            Container(
              color: Colors.transparent,
              child: Image.asset('assets/images/failed.png'),
            ),
            transitionDuration: const Duration(seconds: 1),
            transitionCurve: Curves.easeInOutCirc);
        await soundEffect.play(failedSoundId!);
        await Future.delayed(const Duration(seconds: 5), () {
          clearAll();
          Get.back();
        });
      }
      clearAll();
      AudioHelper.playMusic();
    }
  }

  Future<void> initSound() async {
    correctSoundId =
        await soundEffect.loadAssetAudioFile("assets/sounds/correct.wav");
    failedSoundId =
        await soundEffect.loadAssetAudioFile("assets/sounds/fail.wav");
  }

  @override
  Future<void> init() async {
    await initSound();
    String randomAnswer = correctAnswer + getRandomString(5);
    _keyboardAnswer =
        randomAnswer.split("").map((e) => CrossWordModelUI(value: e)).toList();
    _keyboardAnswer.shuffle();
    notifyListeners();
  }

  @override
  void clearAll() {
    _keyboardAnswer.map((e) => e.isSelected = false).toList();
    _answer.clear();
    notifyListeners();
  }

  @override
  set setCorrectAnswer(String correctAnswer) {
    _correctAnswer = correctAnswer.toUpperCase();
    notifyListeners();
  }

  @override
  set setMessageId(String messageId) {
    _messageId = messageId;
    notifyListeners();
  }

  @override
  set setGroupId(String groupId) {
    _groupId = groupId;
    notifyListeners();
  }
}
