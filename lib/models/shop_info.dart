import 'package:equatable/equatable.dart';

class ShopModel extends Equatable {
  final String name;
  final String description;
  final String timesOfWork;

  const ShopModel({
    required this.name,
    required this.description,
    required this.timesOfWork,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        timesOfWork,
      ];

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      name: json['Название'],
      description: json['Описание'],
      timesOfWork: json['Время работы'],
    );
  }

  Map<String, dynamic> toJson(ShopModel model) {
    return {
      'Название': model.name,
      'Описание': model.description,
      'Время работы': model.timesOfWork,
    };
  }
}
