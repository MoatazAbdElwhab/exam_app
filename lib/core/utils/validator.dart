class Validator {
  static userNameValidation(name) {
    const pattern = r'^[a-zA-Z ]+$';
    return RegExp(pattern).hasMatch(name);
  }

  static phoneNumberValidation(name) {
    const pattern = r"^[0-9]{10,15}$";
    return RegExp(pattern).hasMatch(name);
  }

  static passwordValidation(password) {
    const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    return RegExp(pattern).hasMatch(password);
  }

  static lastNameValidation(name) {
    const pattern = r"^[a-zA-Z]{2,30}$";
    return RegExp(pattern).hasMatch(name);
  }

  static firstNameValidation(name) {
    const pattern = r"^[a-zA-Z]{2,30}$";
    return RegExp(pattern).hasMatch(name);
  }

  static bool emailValidate(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
