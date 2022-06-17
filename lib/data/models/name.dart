import 'package:crud_bloc/data/validator/valid_form_field.dart';

class Name implements ValidFormField {
  final String name;
  final String regex;
  Name({required this.name, required this.regex}) : _regExp = RegExp(regex);

  final RegExp _regExp;

  @override
  bool get isInvalid => _regExp.hasMatch(name) == false;

  @override
  bool get isValid => _regExp.hasMatch(name) == true;
}
