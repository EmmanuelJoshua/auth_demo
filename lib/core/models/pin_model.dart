import 'dart:convert';

class PinModel {
  late String pin;
  late bool isPin6;

  PinModel({
    required this.pin,
    required this.isPin6,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pin': pin,
      'isPin6': isPin6,
    };
  }

  factory PinModel.fromMap(Map<String, dynamic> map) {
    return PinModel(
      pin: map['pin'],
      isPin6: map['isPin6'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PinModel.fromJson(String source) =>
      PinModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
