import 'package:bloc/bloc.dart';
import 'package:crud_bloc/utils/regex.dart';
import 'package:equatable/equatable.dart';

part 'pet_validation_state.dart';

class PetValidationCubit extends Cubit<PetValidationState> {
  PetValidationCubit()
      : super(const PetValidating(validationMessages: <String, dynamic>{
          'nameMessage': '',
          'ageMessage': '',
          'breedMessage': '',
        }));

  void validateForm(String name, String age, String breed) {
    final validationMessages = <String, dynamic>{};
    bool formInvalid = false;
    final textValidation = RegExp(regexInputText);
    final numberValidation = RegExp(regexNumberInput);

    if (textValidation.hasMatch(name)) {
      validationMessages['nameMessage'] = '';
    } else {
      formInvalid = true;
      validationMessages['nameMessage'] = 'Informe um nome';
    }

    if (numberValidation.hasMatch(age)) {
      validationMessages['ageMessage'] = '';
    } else {
      formInvalid = true;
      validationMessages['ageMessage'] = 'A idade deve ser maior que 0';
    }

    if (textValidation.hasMatch(breed)) {
      validationMessages['breedMessage'] = '';
    } else {
      formInvalid = true;
      validationMessages['breedMessage'] = 'Informe a raça';
    }

    if (formInvalid == true) {
      emit(PetValidating(validationMessages: validationMessages));
    } else {
      emit(const PetValidated());
    }
  }
}
