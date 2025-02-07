// core/functions/username_validate.dart
userNAmeValidation(name) {
  const pattern = r'^[a-zA-Z ]+$';
  return RegExp(pattern).hasMatch(name);
}