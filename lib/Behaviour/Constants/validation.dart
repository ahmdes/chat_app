class Validation {
  static bool isValidPassword(String password) {
    return RegExp(
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,20}$",
    ).hasMatch(password);
  }

  static bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$",
    ).hasMatch(email);
  }

  static String? emailValidation(String? data) {
    if (data == null || data.isEmpty) {
      return "Email is required";
    } else if (!isValidEmail(data)) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? passwordValidation(String? data) {
    if (data == null || data.isEmpty) {
      return "Password is required";
    } else if (!isValidPassword(data)) {
      return "Enter a valid password";
    }
    return null;
  }
}
