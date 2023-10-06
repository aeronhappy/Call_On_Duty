import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final String id;
  final String value;
  const AnswerModel({
    required this.id,
    required this.value,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      value: json['value'],
    );
  }

  Map toJson() => {
        'id': id,
        'value': value,
      };

  @override
  List<Object?> get props => [
        id,
        value,
      ];
}
