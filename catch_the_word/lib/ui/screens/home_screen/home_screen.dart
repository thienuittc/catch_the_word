import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';

import '../../../../core/model_ui/cross_word_model_ui.dart';
import '../../../../core/view_models/screen/interfaces/iquestion_viewmodel.dart';
import '../../base_screen/base_screen.dart';
import 'widgets/cross_word.dart';
import 'widgets/empty_cross_word.dart';
import 'widgets/header.dart';

class HomeScreenArguments {
  final Uint8List picture;
  HomeScreenArguments({required this.picture});
}

class HomeScreen extends BaseScreen {
  const HomeScreen({Key? key, required this.arguments}) : super(key: key);
  final HomeScreenArguments arguments;
  @override
  Widget build() {
    return _HomeScreen(arguments: arguments);
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key, required this.arguments}) : super(key: key);
  final HomeScreenArguments arguments;

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      context.read<IQuestionViewModel>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Header(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.memory(widget.arguments.picture),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 30.h,
              bottom: 30.h,
            ),
            child: Consumer<IQuestionViewModel>(
              builder: (_, vm, __) {
                return CrossWords(
                  length: vm.correctAnswerLength,
                  crossWords: vm.answer,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Consumer<IQuestionViewModel>(
              builder: (_, vm, __) {
                return VirualKeyBoard(
                  crossWords: vm.keyboardAnswer,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class VirualKeyBoard extends StatelessWidget {
  final List<CrossWordModelUI> crossWords;
  const VirualKeyBoard({Key? key, required this.crossWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.sp,
          runSpacing: 10.sp,
          children: <Widget>[
            ...crossWords
                .map(
                  (word) => CrossWord(
                    isDisabled: word.isSelected,
                    char: word.value,
                    onTap: () {
                      context
                          .read<IQuestionViewModel>()
                          .selectCrossWord(word.id);
                    },
                  ),
                )
                .toList(),
          ]),
    );
  }
}

class CrossWords extends StatelessWidget {
  final List<CrossWordModelUI> crossWords;
  final int length;
  const CrossWords({Key? key, required this.crossWords, required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      for (int i = 0; i < length; i++)
        CrossWordEmpty(
          char: crossWords.length - 1 >= i ? crossWords[i].value : "",
        )
    ]);
  }
}
