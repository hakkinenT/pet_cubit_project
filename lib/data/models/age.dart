import 'package:crud_bloc/data/validator/valid_form_input.dart';
import 'package:crud_bloc/utils/regex.dart';

class Age implements ValidFormInput {
  final String age;
  Age({required this.age});

  final RegExp _regExp = RegExp(regexNumberInput);

  @override
  bool get isInvalid => _regExp.hasMatch(age) == false;

  @override
  bool get isValid => _regExp.hasMatch(age) == true;

  @override
  String? get onError {
    if (isInvalid) {
      return 'A idade deve ser maior do que 0';
    } else {
      return null;
    }
  }
}
