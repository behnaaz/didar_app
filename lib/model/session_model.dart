class SessionModel {
  final String type;
  final String audience;
  final String durationTime;
  final String numOfSessions;
  final String capacity;
  final String price;
  final String info;
  final String color;

  SessionModel({
    required this.type,
    required this.audience,
    required this.durationTime,
    required this.numOfSessions,
    required this.capacity,
    required this.price,
    required this.info,
    required this.color,
  }
  );

  factory SessionModel.fromJson(json) {
    return SessionModel(
      type: json["session_type"],
      audience: json["audience"],
      durationTime: json["duration"],
      numOfSessions: json["session_num"],
      capacity: json["capacity"],
      price: json["price"],
      info: json["info"],
      color: json["color"], 
    );
  }

  Map<String, Object?> toJson() {
  return {
    'session_type': type,
    'audience': audience,
    'duration': durationTime,
    'session_num': numOfSessions,
    'capacity': capacity,
    'price': price,
    'info': info,
    'color': color,
  };
}
}


