import '../models/camera.dart';

abstract class ICamerasRepository {
  Future<({List<Camera>? result, String? error})> findAll();
  Future<({Camera? result, String? error})> findById(String id);
  Future<({bool? result, String? error})> sendRequest(Camera camera);
}
