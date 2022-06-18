import 'package:bloc/bloc.dart';
import 'package:crud_bloc/data/models/age.dart';
import 'package:crud_bloc/data/models/breed.dart';
import 'package:crud_bloc/data/models/name.dart';
import 'package:crud_bloc/data/models/pet.dart';
import 'package:crud_bloc/data/validator/valid_form.dart';
import 'package:crud_bloc/data/validator/valid_form_input.dart';
import 'package:crud_bloc/utils/regex.dart';
import 'package:equatable/equatable.dart';

part 'new_pet_validation_state.dart';

class NewPetValidationCubit extends Cubit<NewPetValidationState> {
  NewPetValidationCubit() : super(const PetValidating());

  void validateForm(Pet pet) {
    final name = Name(name: pet.name);
    final age = Age(age: pet.age);
    final breed = Breed(breed: pet.breed);

    final validFormInputs = <ValidFormInput>[name, age, breed];
    final validForm = ValidForm(validFormInputs: validFormInputs);

    if (validForm.isValidate) {
      emit(const PetValidated());
    } else {
      emit(PetValidating(name: name, age: age, breed: breed));
    }
  }
}
