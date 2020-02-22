class Validator {
  Validator({this.field});

  final String field;

  String makeValidator(value) {
    if (value.isEmpty) {
      return "${this.field} is Required";
    } else {
      return null;
    }
  }
}
