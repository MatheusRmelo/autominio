import 'package:autominio/features/cameras/domain/use_cases/send_request_usecase.dart';

import '../../../injection_container.dart';
import '../data/data_sources/i_cameras_remote_datasource.dart';
import '../data/data_sources/cameras_remote_datasource.dart';
import '../data/repositories/cameras_repository.dart';
import '../domain/repositories/i_cameras_repository.dart';
import '../domain/use_cases/get_camera_usecase.dart';
import '../domain/use_cases/list_camera_dynamic_fields_usecase.dart';
import '../domain/use_cases/get_cameras_usecase.dart';
import '../presentation/camera/bloc/camera_bloc.dart';
import '../presentation/cameras/bloc/cameras_bloc.dart';

class CamerasInjectionContainer {
  void call(InjectionContainer dependency) {
    dependency.registerFactory<ICamerasRemoteDataSource>(
      () => CamerasRemoteDataSource(),
    );

    dependency.registerFactory<ICamerasRepository>(
      () => CamerasRepository(
        remoteDataSource: dependency.get<ICamerasRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<GetCamerasUsecase>(
      () => GetCamerasUsecase(repository: dependency.get<ICamerasRepository>()),
    );

    dependency.registerFactory<GetCameraUsecase>(
      () => GetCameraUsecase(repository: dependency.get<ICamerasRepository>()),
    );

    dependency.registerFactory<SendRequestUsecase>(
      () =>
          SendRequestUsecase(repository: dependency.get<ICamerasRepository>()),
    );

    dependency.registerFactory<ListCameraDynamicFieldsUsecase>(
      () => ListCameraDynamicFieldsUsecase(),
    );

    dependency.registerFactory<CamerasBloc>(
      () => CamerasBloc(getCamerasUsecase: dependency.get<GetCamerasUsecase>()),
    );

    dependency.registerFactory<CameraBloc>(
      () => CameraBloc(
          getCameraUsecase: dependency.get<GetCameraUsecase>(),
          sendRequestUsecase: dependency.get<SendRequestUsecase>()),
    );
  }
}
