import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/camera.dart';
import '../../../domain/use_cases/get_cameras_usecase.dart';

part 'cameras_state.dart';
part 'cameras_event.dart';

class CamerasBloc extends Bloc<CamerasEvent, CamerasState> {
  final GetCamerasUsecase getCamerasUsecase;
  CamerasBloc({required this.getCamerasUsecase}) : super(CamerasInitial()) {
    on<GetCameras>((event, emit) async {
      await _getCameras(emit);
    });
  }

  Future<void> _getCameras(Emitter<CamerasState> emit) async {
    emit(CamerasLoading());
    var response = await getCamerasUsecase.call();
    if (response.error != null) {
      emit(CamerasError((response.error!)));
    } else {
      emit(CamerasLoaded(response.result!));
    }
  }
}
