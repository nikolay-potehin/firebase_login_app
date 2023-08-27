class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!email.contains('@') || !email.contains('.')) {
      return 'Email adress is badly formatted';
    }
    return null;
  }

  static String? validatePassword(String? password, {String? compareTo}) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password should be at least 6 symbols';
    }
    if (compareTo != null && password != compareTo) {
      return 'Password do not match';
    }
    return null;
  }
}
