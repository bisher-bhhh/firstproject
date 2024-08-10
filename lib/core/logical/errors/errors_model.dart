typedef ErrorDictionary = List<MapEntry<String, String>>;

class ErrorModel {
  ErrorModel({
    required this.message,
    required this.success,
    required this.status,
    required this.messageDic,
  });

  final bool? success;
  final int? status;
  final ErrorDictionary? messageDic;
  final String? message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json["details"] is String? ? json["details"] : null,
      messageDic: json['message'] != null && json["message"] is Map
          ? (json["message"] as Map)
              .entries
              .map<MapEntry<String, String>>(
                (item) => MapEntry(item.key, (item.value as List).map((e) => e as String).toList().join('\n')),
              )
              .toList()
          : null,
      success: json["success"],
      status: json["status"],
    );
  }
}

class Message {
  Message({
    required this.email,
  });

  final List<String> email;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
    );
  }
}
