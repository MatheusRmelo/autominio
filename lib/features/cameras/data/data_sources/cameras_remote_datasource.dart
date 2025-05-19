import 'package:autominio/core/network/remote/api_client.dart';

import '../../../../core/models/response.dart';
import 'i_cameras_remote_datasource.dart';

class CamerasRemoteDataSource implements ICamerasRemoteDataSource {
  List<Map<String, dynamic>> cameras = [
    {
      "id": 1,
      "name": "Quarto",
      "rtsp":
          "rtsp://rtspstream:VfhwX0pn5oMCyFINwpAk0@zephyr.rtsp.stream/movie",
      "http": "https://pokeapi.co/api/v2/pokemon/1"
    },
    {
      "id": 2,
      "name": "Quintal",
      "rtsp":
          "rtsp://rtspstream:VfhwX0pn5oMCyFINwpAk0@zephyr.rtsp.stream/pattern",
      "http": "https://pokeapi.co/api/v2/pokemon/12"
    },
    {
      "id": 3,
      "name": "Garagem",
      "rtsp":
          "rtsp://rtspstream:VfhwX0pn5oMCyFINwpAk0@zephyr.rtsp.stream/pattern2",
      "http": "https://pokeapi.co/api/v2/pokemon/13"
    }
  ];
  @override
  Future<Response> findAll() async {
    return Success(cameras);
  }

  @override
  Future<Response> findById(String id) async {
    Map<String, dynamic>? camera =
        cameras.where((element) => element['id'].toString() == id).firstOrNull;
    if (camera == null) {
      return Failure(message: 'Camera não encontrada');
    }
    return Success<dynamic>(camera);
  }

  @override
  Future<Response> sendRequest(String link) async {
    final ApiClient client = ApiClient(baseUrl: link);

    final response = await client.get('');
    if (response.ok) {
      if (response.result is List) {
        return Success<List<dynamic>>(response.result);
      }
      return Success(response.result);
    }
    return Failure(response: response.result);
  }
}
