class Validator {
  static String? userNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r'^[a-zA-Z ]+$',
    );
    if (name == null || name.trim().isEmpty) {
      return 'Please enter your user name';
    } else if (nameRegex.hasMatch(name) == false) {
      return 'Enter valid user name';
    } else if (name.length < 8) {
      return 'Username must be at least 8 characters';
    } else {
      return null;
    }
  }

  static String? phoneNumberValidation(String? number) {
    final RegExp numberRegex = RegExp(
      r"^[0-9]{10,15}$",
    );
    if (number == null || number.trim().isEmpty) {
      return 'please enter your phone number';
    } else if (numberRegex.hasMatch(number) == false) {
      return 'enter valid phone number';
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    if (password == null || password.trim().isEmpty) {
      return 'Please enter your password';
    } else if (passwordRegex.hasMatch(password) == false) {
      return 'The password is not valid';
    } else {
      return null;
    }
  }

  static String? lastNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'please enter your last name';
    } else if (nameRegex.hasMatch(name) == false) {
      return 'enter valid last name';
    } else {
      return null;
    }
  }

  static String? firstNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'please enter your first name';
    } else if (nameRegex.hasMatch(name) == false) {
      return 'enter valid first name';
    } else {
      return null;
    }
  }

  static String? emailValidate(String? email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (email == null || email.trim().isEmpty) {
      return 'please enter your email';
    } else if (emailRegex.hasMatch(email) == false) {
      return 'This Email is not valid';
    } else {
      return null;
    }
  }
}
