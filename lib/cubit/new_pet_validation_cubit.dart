import 'package:bloc/bloc.dart';
import 'package:crud_bloc/data/models/age.dart';
import 'package:crud_bloc/data/models/breed.dart';
import 'package:crud_bloc/data/models/name.dart';
import 'package:crud_bloc/data/models/pet.dart';
import 'package:crud_bloc/data/validator/valid_form.dart';
import 'package:crud_bloc/data/validator/valid_form_field.dart';
import 'package:crud_bloc/utils/regex.dart';
import 'package:equatable/equatable.dart';

part 'new_pet_validation_state.dart';

class NewPetValidationCubit extends Cubit<NewPetValidationState> {
  NewPetValidationCubit()
      : super(const PetValidating(validationMessages: <String, dynamic>{
          'nameMessages': '',
          'ageMessages': '',
          'breedMessages': ''
        }));

  void validateForm(Pet pet) {
    final name = Name(name: pet.name, regex: regexInputText);
    final age = Age(age: pet.age, regex: regexNumberInput);
    final breed = Breed(breed: pet.breed, regex: regexInputText);

    final validationMessages = <String, dynamic>{};

    final validFormFields = <ValidFormField>[name, age, breed];
    final validForm = ValidForm(validFormFields: validFormFields);

    if (name.isValid) {
      validationMessages['nameMessage'] = '';
    } else {
      validationMessages['nameMessage'] = 'Informe um nome';
    }

    if (age.isValid) {
      validationMessages['ageMessage'] = '';
    } else {
      validationMessages['ageMessage'] = 'A idade deve ser maior que 0';
    }

    if (breed.isValid) {
      validationMessages['breedMessage'] = '';
    } else {
      validationMessages['breedMessage'] = 'Informe a raça';
    }

    if (validForm.isValidate == false) {
      emit(PetValidating(validationMessages: validationMessages));
    } else {
      emit(const PetValidated());
    }
  }
}
