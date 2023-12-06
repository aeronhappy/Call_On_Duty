import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final String id;
  final String value;
  final String image;
  final String video;
  const AnswerModel({
    required this.id,
    required this.value,
    required this.image,
    required this.video,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      value: json['value'],
      image: json['image'],
      video: json['video'],
    );
  }

  Map toJson() => {
        'id': id,
        'value': value,
        'image': image,
        'video': video,
      };

  @override
  List<Object?> get props => [id, value, image, video];
}
