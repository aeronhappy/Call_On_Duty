import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final String id;
  final String value;
  final String image;
  const AnswerModel({
    required this.id,
    required this.value,
    required this.image,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      value: json['value'],
      image: json['image'],
    );
  }

  Map toJson() => {
        'id': id,
        'value': value,
        'image': image,
      };

  @override
  List<Object?> get props => [id, value, image];
}
