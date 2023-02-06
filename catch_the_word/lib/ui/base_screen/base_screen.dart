import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
  Widget build();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
      child: Stack(
        children: [
          const _Clould(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: SizedBox(
          //       height: 300.h,
          //       width: 200.w,
          //       child: Lottie.asset('assets/lottie_files/cat_fly.json')),
          // ),
          widget.build(),
        ],
      ),
    );
  }
}

class _Clould extends StatefulWidget {
  const _Clould({Key? key}) : super(key: key);

  @override
  State<_Clould> createState() => __ClouldState();
}

class __ClouldState extends State<_Clould> {
  bool play = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        play = !play;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: 300.w,
      height: 200.h,
      top: 50.h,
      left: play ? -300.w : 1.3.sw,
      duration: Duration(seconds: play ? 10 : 0),
      child: Image.asset("assets/images/clould.png"),
      onEnd: () {
        Future.delayed(Duration.zero, () {
          setState(() {
            play = !play;
          });
        });
      },
    );
  }
}
