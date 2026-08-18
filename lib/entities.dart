import 'dart:convert';

class RemoteConfigDataEnt {
  int? timestamp;
  String? data;

  RemoteConfigDataEnt({this.timestamp, this.data});

  String toJson() {
    return jsonEncode({
      'timestamp': timestamp,
      'data': data,
    });
  }

  factory RemoteConfigDataEnt.fromJson(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return RemoteConfigDataEnt(
      timestamp: jsonMap['timestamp'],
      data: jsonMap['data'],
    );
  }
}
