class AllSessionModel {
  static final String LIST = 'type';
  List list;
  AllSessionModel({
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      LIST: list,
    };
  }

  factory AllSessionModel.fromJson(json) {
    return AllSessionModel(
      list: json[LIST],
    );
  }
}
