import 'package:uuid/uuid.dart';

class Pet {
  final String? id;
  final String name;
  final String age;
  final String breed;

  Pet({this.id, required this.name, required this.age, required this.breed});

  Pet copyWith({String? id, String? name, String? age, String? breed}) {
    return Pet(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        breed: breed ?? this.breed);
  }
}
