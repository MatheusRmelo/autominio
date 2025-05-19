class Camera {
  String? id;
  String name;
  String rtsp;
  String http;

  Camera({
    this.id,
    required this.name,
    required this.rtsp,
    required this.http,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        id: json['id'] is int ? json['id'].toString() : json['id'],
        name: json['name'] ?? '',
        rtsp: json['rtsp'] ?? '',
        http: json['http'] ?? '',
      );

  factory Camera.fromJsonForm(Map<String, String> json) => Camera(
        id: json['id'],
        name: json['name'] ?? '',
        rtsp: json['rtsp'] ?? '',
        http: json['http'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rtsp": rtsp,
        "http": http,
      };
}
