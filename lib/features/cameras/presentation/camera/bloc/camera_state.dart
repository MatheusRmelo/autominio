part of 'camera_bloc.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraBusy extends CameraState {}

class CameraLoaded extends CameraState {
  final Camera data;
  CameraLoaded(this.data);
}

class SuccessRequested extends CameraState {
  SuccessRequested();
}

class ErrorRequested extends CameraState {
  final String message;
  ErrorRequested(this.message);
}

class CameraError extends CameraState {
  final String message;
  CameraError(this.message);
}
