import '../../../../core/models/response.dart';
import '../../domain/models/camera.dart';
import '../../domain/repositories/i_cameras_repository.dart';
import '../data_sources/i_cameras_remote_datasource.dart';

class CamerasRepository implements ICamerasRepository {
  final ICamerasRemoteDataSource remoteDataSource;
  CamerasRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({List<Camera>? result, String? error})> findAll() async {
    var response = await remoteDataSource.findAll();
    if (response is Success) {
      return (
        result: (response.data as List)
            .map((element) => Camera.fromJson(element))
            .toList(),
        error: null
      );
    } else if (response is Failure) {
      return (result: null, error: response.error);
    } else {
      return (result: null, error: 'Falha desconhecida');
    }
  }

  @override
  Future<({Camera? result, String? error})> findById(String id) async {
    var response = await remoteDataSource.findById(id);
    if (response is Success) {
      return (result: Camera.fromJson(response.data), error: null);
    } else if (response is Failure) {
      return (result: null, error: response.error);
    } else {
      return (result: null, error: 'Falha desconhecida');
    }
  }

  @override
  Future<({String? error, bool? result})> sendRequest(Camera camera) async {
    var response = await remoteDataSource.sendRequest(camera.http);
    if (response is Success) {
      return (result: true, error: null);
    } else if (response is Failure) {
      return (result: false, error: response.error);
    } else {
      return (result: null, error: 'Falha desconhecida');
    }
  }
}
