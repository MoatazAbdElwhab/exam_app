// core/utils/validator.dart
class Validator {
  // User Name Validation: Allowing spaces, apostrophes, and hyphens
  static String? userNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z' -]+$", // Allow apostrophes, spaces, and hyphens
    );
    name = name?.trim(); // Trim spaces from both ends
    if (name == null || name.isEmpty) {
      return 'Please enter your user name';
    } else if (!nameRegex.hasMatch(name)) {
      return 'Enter a valid user name';
    } else if (name.length < 8) {
      return 'Username must be at least 8 characters';
    } else {
      return null;
    }
  }

  // Phone Number Validation (Egyptian format as an example)
  static String? phoneNumberValidation(String? number) {
    final RegExp numberRegex = RegExp(
      r"^01[0125][0-9]{8}$", // Egyptian phone number format (01[0125][0-9]{8})
    );
    if (number == null || number.trim().isEmpty) {
      return 'Please enter your phone number';
    } else if (!numberRegex.hasMatch(number)) {
      return 'Phone number must start with 01 and be 11 digits';
    } else {
      return null;
    }
  }

  // Password Validation: Ensuring it contains uppercase, lowercase, number, and special character
  static String? passwordValidation(String? password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', // Added special character requirement
    );
    if (password == null || password.trim().isEmpty) {
      return 'Please enter your password';
    } else if (!passwordRegex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
    } else {
      return null;
    }
  }

  // Last Name Validation: Allowing only letters, and making it flexible for hyphen or apostrophe
  static String? lastNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z' -]{2,30}$", // Allow apostrophes, spaces, and hyphens
    );
    if (name == null || name.trim().isEmpty) {
      return 'Please enter your last name';
    } else if (!nameRegex.hasMatch(name)) {
      return 'Enter a valid last name';
    } else {
      return null;
    }
  }

  // First Name Validation: Allowing only letters, and making it flexible for hyphen or apostrophe
  static String? firstNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z' -]{2,30}$", // Allow apostrophes, spaces, and hyphens
    );
    if (name == null || name.trim().isEmpty) {
      return 'Please enter your first name';
    } else if (!nameRegex.hasMatch(name)) {
      return 'Enter a valid first name';
    } else {
      return null;
    }
  }

  // Email Validation: Standard email regex (adjust if needed for international characters)
  static String? emailValidate(String? email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (email == null || email.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }
}
