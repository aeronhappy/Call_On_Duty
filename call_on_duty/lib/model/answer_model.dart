import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final String id;
  final String value;
  final String image;
  final String explanation;
  final String video;
  const AnswerModel({
    required this.id,
    required this.value,
    required this.image,
    required this.explanation,
    required this.video,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      value: json['value'],
      image: json['image'],
      explanation: json['explanation'],
      video: json['video'],
    );
  }

  Map toJson() => {
        'id': id,
        'value': value,
        'image': image,
        'explanation': explanation,
        'video': video,
      };

  @override
  List<Object?> get props => [id, value, image, explanation, video];
}
