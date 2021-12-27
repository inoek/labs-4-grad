import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

extension SafeGetIt on GetIt {
  T? getIfRegistered<T extends Object>(
          {Object? instance, String? instanceName}) =>
      isRegistered<T>(instanceName: instanceName, instance: instance)
          ? get<T>(instanceName: instanceName)
          : null;
}
