class SessionModel {
  static final String TYPE = 'session_type';
  static final String AUDIENCE = 'audience';
  static final String DURATION_TIME = 'duration';
  static final String NUM_OF_SESSIONS = 'session_num';
  static final String CAPACITY = 'capacity';
  static final String PRICE = 'price';
  static final String INFO = 'info';
  static final String COLOR = 'color';
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
  });

  factory SessionModel.fromJson(json) {
    return SessionModel(
      type: json[TYPE],
      audience: json[AUDIENCE],
      durationTime: json[DURATION_TIME],
      numOfSessions: json[NUM_OF_SESSIONS],
      capacity: json[CAPACITY],
      price: json[PRICE],
      info: json[INFO],
      color: json[COLOR],
    );
  }

  Map<String, Object?> toMap() {
    return {
      TYPE: type,
      AUDIENCE: audience,
      DURATION_TIME: durationTime,
      NUM_OF_SESSIONS: numOfSessions,
      CAPACITY: capacity,
      PRICE: price,
      INFO: info,
      COLOR: color,
    };
  }
}
