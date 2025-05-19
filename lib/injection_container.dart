import 'package:get_it/get_it.dart';

import 'core/navigation/manager/navigation_cubit.dart';
import 'features/cameras/injection_container/cameras_injection_container.dart';

class InjectionContainer {
  final GetIt _getIt = GetIt.instance;

  void registerFactory<T extends Object>(T Function() instance) {
    _getIt.registerFactory<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T Function() instance) {
    _getIt.registerLazySingleton<T>(instance);
  }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  void init() {
    final CamerasInjectionContainer usersInjectionContainer =
        CamerasInjectionContainer();

    registerLazySingleton<NavigationCubit>(
      () => NavigationCubit(),
    );

    usersInjectionContainer(this);
  }
}
