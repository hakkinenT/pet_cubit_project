import 'package:crud_bloc/data/validator/valid_form_field.dart';

class Age implements ValidFormField {
  final String age;
  final String regex;
  Age({required this.age, required this.regex}) : _regExp = RegExp(regex);

  final RegExp _regExp;

  @override
  bool get isInvalid => _regExp.hasMatch(age) == false;

  @override
  bool get isValid => _regExp.hasMatch(age) == true;
}
