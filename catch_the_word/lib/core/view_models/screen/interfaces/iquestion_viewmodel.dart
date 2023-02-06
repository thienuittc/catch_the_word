
import 'package:flutter/material.dart';

import '../../../model_ui/cross_word_model_ui.dart';

abstract class IQuestionViewModel with ChangeNotifier {
  List<CrossWordModelUI> get answer;
  List<CrossWordModelUI> get keyboardAnswer;
  int get correctAnswerLength;
  String get correctAnswer;
  void selectCrossWord(String id);
  Future<void> init();
  void clearAll();
}
