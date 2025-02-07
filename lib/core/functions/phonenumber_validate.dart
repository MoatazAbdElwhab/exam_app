// core/functions/phonenumber_validate.dart


phoneNumberValidation(name) {
  const pattern = r"^[0-9]{10,15}$";
  return RegExp(pattern).hasMatch(name);
}