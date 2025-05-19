import '../models/camera.dart';
import '../repositories/i_cameras_repository.dart';

class SendRequestUsecase {
  final ICamerasRepository repository;
  SendRequestUsecase({required this.repository});

  Future<({bool? result, String? error})?> call(Camera camera) async {
    var response = await repository.sendRequest(camera);
    return response;
  }
}
