import 'package:equatable/equatable.dart';
import 'meal.dart';

class Categories extends Equatable {
  final String id;
  final String name;
  final List<Meal> entries;

  const Categories({
    required this.id,
    required this.name,
    required this.entries,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        entries,
      ];
}
