// core/functions/secondname_validate.dart
lastNAmeValidation(name) {
  const pattern = r"^[a-zA-Z]{2,30}$";
  return RegExp(pattern).hasMatch(name);
}