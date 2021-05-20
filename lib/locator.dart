import 'package:get_it/get_it.dart';

import 'firebase/analytics_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AnalyticsService());
}