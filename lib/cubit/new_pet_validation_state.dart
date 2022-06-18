part of 'new_pet_validation_cubit.dart';

abstract class NewPetValidationState extends Equatable {
  const NewPetValidationState();

  @override
  List<Object?> get props => [];
}

class PetValidating extends NewPetValidationState {
  const PetValidating({this.name, this.age, this.breed});

  final Name? name;
  final Age? age;
  final Breed? breed;

  PetValidating copyWith({Name? name, Age? age, Breed? breed}) {
    return PetValidating(
        name: name ?? this.name,
        age: age ?? this.age,
        breed: breed ?? this.breed);
  }

  @override
  List<Object?> get props => [name, age, breed];
}

class PetValidated extends NewPetValidationState {
  const PetValidated();
}
