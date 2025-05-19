import '../models/camera.dart';
import '../repositories/i_cameras_repository.dart';

class GetCamerasUsecase {
  final ICamerasRepository repository;
  GetCamerasUsecase({required this.repository});

  Future<({List<Camera>? result, String? error})> call() async {
    var response = await repository.findAll();
    return response;
  }
}
