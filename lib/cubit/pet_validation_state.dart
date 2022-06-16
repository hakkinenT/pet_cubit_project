part of 'pet_validation_cubit.dart';

abstract class PetValidationState extends Equatable {
  const PetValidationState();

  @override
  List<Object?> get props => [];
}

class PetValidating extends PetValidationState {
  const PetValidating({this.validationMessages});
  final Map<String, dynamic>? validationMessages;

  PetValidating copyWith({Map<String, dynamic>? validationMessages}) {
    return PetValidating(
        validationMessages: validationMessages ?? this.validationMessages);
  }

  @override
  List<Object?> get props => [validationMessages];
}

class PetValidated extends PetValidationState {
  const PetValidated();
}
