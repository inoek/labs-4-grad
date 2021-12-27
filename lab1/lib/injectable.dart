import 'package:injectable/injectable.dart';

import 'injectable.config.dart';
import 'service_locator.dart';

@InjectableInit()
Future<void> configureDependencies(String environment) async {
  $initGetIt(locator, environment: environment);
}
