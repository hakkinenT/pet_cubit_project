import 'package:crud_bloc/data/validator/valid_form_field.dart';

class Breed implements ValidFormField {
  final String breed;
  final String regex;
  Breed({required this.breed, required this.regex}) : _regExp = RegExp(regex);

  final RegExp _regExp;

  @override
  bool get isInvalid => _regExp.hasMatch(breed) == false;

  @override
  bool get isValid => _regExp.hasMatch(breed) == true;
}
