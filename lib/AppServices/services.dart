import 'package:get_it/get_it.dart';
import 'NavigatorService.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
}
