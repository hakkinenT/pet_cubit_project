part of 'new_pet_validation_cubit.dart';

abstract class NewPetValidationState extends Equatable {
  const NewPetValidationState();

  @override
  List<Object> get props => [];
}

class PetValidating extends NewPetValidationState {
  const PetValidating({required this.validationMessages});
  final Map<String, dynamic> validationMessages;

  PetValidating copyWith({Map<String, dynamic>? validationMessages}) {
    return PetValidating(
        validationMessages: validationMessages ?? this.validationMessages);
  }

  @override
  List<Object> get props => [validationMessages];
}

class PetValidated extends NewPetValidationState {
  const PetValidated();
}
