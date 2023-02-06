import 'package:get_it/get_it.dart';

import 'locator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
    registerServiceSingletons(locator);
}
