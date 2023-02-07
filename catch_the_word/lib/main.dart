import 'package:audio_helper/audio_helper.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'core/global/locator.dart';
import 'core/global/providers.dart';
import 'core/global/router.dart';
import 'ui/screens/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await AudioHelper.initial(
        backgroundPrefix: 'assets/sounds/background/',
        backgroundMusicNames: [
          'b1.mp3',
          'b2.mp3',
          'b3.mp3',
          'b4.mp3',
          'b5.mp3', 
          'b6.mp3',
        ],
      );
      AudioHelper.playMusic();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...viewModelProviders],
      child: ScreenUtilInit(
        designSize: const Size(411, 822),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          title: 'Catch the word',
          onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
          initialRoute: MyRouter.splash,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'ComicHelvetic',
          ),
        ),
      ),
    );
  }
}
