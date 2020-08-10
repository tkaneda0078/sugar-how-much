class Validator {
  Validator._();

  static bool isNumeric(String input) {
    if (input == null) {
      return false;
    }

    return double.tryParse(input) != null;
  }
}
