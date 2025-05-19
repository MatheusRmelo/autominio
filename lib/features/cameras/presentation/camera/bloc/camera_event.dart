part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class GetCamera extends CameraEvent {
  final String id;
  GetCamera(this.id);
}

class SendRequest extends CameraEvent {
  final Camera camera;
  SendRequest(this.camera);
}
