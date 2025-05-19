abstract class Response {}

class Success<T> extends Response {
  T data;
  Success(this.data);
}

class Failure extends Response {
  final dynamic response;
  final String? message;
  Failure({this.response, this.message});

  String get error {
    try {
      return message ??
          response['mensagem'] ??
          'Ocorreu um erro. Tente novamente mais tarde';
    } catch (e) {
      return 'Ocorreu um erro. Tente novamente mais tarde';
    }
  }
}
