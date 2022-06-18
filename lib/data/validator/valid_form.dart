import 'package:crud_bloc/data/validator/valid_form_input.dart';

class ValidForm {
  final List<ValidFormInput> validFormInputs;

  ValidForm({required this.validFormInputs});

  bool get isValidate {
    bool isValidate = true;

    for (var input in validFormInputs) {
      if (input.isInvalid) {
        isValidate = false;
        return isValidate;
      }
    }
    return isValidate;
  }
}
