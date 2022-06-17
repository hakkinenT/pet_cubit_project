import 'package:crud_bloc/data/validator/valid_form_field.dart';

class ValidForm {
  final List<ValidFormField> validFormFields;

  ValidForm({required this.validFormFields});

  bool get isValidate {
    bool isValidate = true;
    int lenght = validFormFields.length;
    int i = 0;

    while (i < lenght && isValidate == true) {
      if (validFormFields[i].isInvalid) {
        isValidate = false;
      }
      i++;
    }
    return isValidate;
  }
}
