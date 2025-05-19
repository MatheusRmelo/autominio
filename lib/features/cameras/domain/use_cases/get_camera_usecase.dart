import '../models/camera.dart';
import '../repositories/i_cameras_repository.dart';

class GetCameraUsecase {
  final ICamerasRepository repository;
  GetCameraUsecase({required this.repository});

  Future<({Camera? result, String? error})?> call(String id) async {
    var response = await repository.findById(id);
    return response;
  }
}
