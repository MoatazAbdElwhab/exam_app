// core/functions/firstname_validate.dart
firstNAmeValidation(name) {
  const pattern = r"^[a-zA-Z]{2,30}$";
  return RegExp(pattern).hasMatch(name);
}
