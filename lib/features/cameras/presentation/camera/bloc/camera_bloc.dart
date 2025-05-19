import 'package:autominio/features/cameras/domain/use_cases/send_request_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/camera.dart';
import '../../../domain/use_cases/get_camera_usecase.dart';

part 'camera_state.dart';
part 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final GetCameraUsecase getCameraUsecase;
  final SendRequestUsecase sendRequestUsecase;
  CameraBloc({required this.getCameraUsecase, required this.sendRequestUsecase})
      : super(CameraInitial()) {
    on<GetCamera>((event, emit) async {
      await _getCamera(event, emit);
    });
    on<SendRequest>((event, emit) async {
      await _sendRequest(event, emit);
    });
  }

  Future<void> _getCamera(GetCamera event, Emitter<CameraState> emit) async {
    emit(CameraLoading());
    var data = await getCameraUsecase.call(event.id);
    if (data!.result != null) {
      emit(CameraLoaded(data.result!));
    } else if (data.error != null) {
      emit(CameraError(data.error!));
    }
  }

  Future<void> _sendRequest(
      SendRequest event, Emitter<CameraState> emit) async {
    emit(CameraBusy());
    var data = await sendRequestUsecase.call(event.camera);
    if (data!.result != null) {
      emit(SuccessRequested());
    } else if (data.error != null) {
      emit(ErrorRequested(data.error!));
    }
    emit(CameraLoaded(event.camera));
  }
}
