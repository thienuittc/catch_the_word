import 'package:catch_the_word/core/global/global_data.dart';
import 'package:get_it/get_it.dart';

import 'locator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => GlobalData());
  registerServiceSingletons(locator);
}
