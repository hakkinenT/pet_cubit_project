import 'package:crud_bloc/data/validator/valid_form_input.dart';
import 'package:crud_bloc/utils/regex.dart';

class Breed implements ValidFormInput {
  final String breed;

  Breed({required this.breed});

  final RegExp _regExp = RegExp(regexInputText);

  @override
  bool get isInvalid => _regExp.hasMatch(breed) == false;

  @override
  bool get isValid => _regExp.hasMatch(breed) == true;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Informe a raça';
    } else {
      return null;
    }
  }
}
