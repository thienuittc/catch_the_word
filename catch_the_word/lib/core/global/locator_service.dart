
import 'package:get_it/get_it.dart';

import '../firebase/implemnts/firebase_auth.dart';
import '../firebase/implemnts/firebase_message.dart';
import '../firebase/interfaces/ifirebase_auth.dart';
import '../firebase/interfaces/ifirebase_message.dart';
void registerServiceSingletons(GetIt locator) {
  locator.registerLazySingleton<IFirebaseAuthService>(() => FirebaseAuthService());
    locator.registerLazySingleton<IFirebaseMessageService>(() => FirebaseMessageService());
}
