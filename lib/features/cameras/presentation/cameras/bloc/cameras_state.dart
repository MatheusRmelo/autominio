part of 'cameras_bloc.dart';

@immutable
abstract class CamerasState {}

class CamerasInitial extends CamerasState {}

class CamerasLoading extends CamerasState {}

class CamerasLoaded extends CamerasState {
  final List<Camera> data;
  CamerasLoaded(this.data);
}

class CamerasError extends CamerasState {
  final String message;
  CamerasError(this.message);
}
