import '../../../../core/models/response.dart';

abstract class ICamerasRemoteDataSource {
  Future<Response> findAll();
  Future<Response> findById(String id);
  Future<Response> sendRequest(String link);
}
