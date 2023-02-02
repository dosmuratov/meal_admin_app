import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String name;
  final String description;
  final String imageUrl;
  final String id;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
      ];

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
