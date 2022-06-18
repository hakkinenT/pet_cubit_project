import 'package:crud_bloc/data/validator/valid_form_input.dart';
import 'package:crud_bloc/utils/regex.dart';

class Name implements ValidFormInput {
  final String name;

  Name({required this.name});

  final RegExp _regExp = RegExp(regexInputText);

  @override
  bool get isInvalid => _regExp.hasMatch(name) == false;

  @override
  bool get isValid => _regExp.hasMatch(name) == true;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Informe um nome';
    } else {
      return null;
    }
  }
}
