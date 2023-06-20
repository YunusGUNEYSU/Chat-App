class FormValitadion {
  FormValitadion._();
  static String? emailPasswordValitadion(String value) {
    if (value.isEmpty) {
      return "Please enter your email and password";
    }
    return null;
  }
}
