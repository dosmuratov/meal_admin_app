import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String name;
  final String description;
  final String imageUrl;
  final String id;
  final String price;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
      ];

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
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
