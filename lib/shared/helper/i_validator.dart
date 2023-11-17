import 'package:fpdart/fpdart.dart';

class StringValidator {
  static Option<String> isNotEmptyValidate(String value) {
    return value.isNotEmpty.match(
      () => const Some("Bu alanın doldurulması zorunludur."),
      () => const None(),
    );
  }

  static StringValidator i = StringValidator();
}

class Validator {
  static List<String> validate(List<Option<String>> validators) {
    List<String> errors = [];
    for (var validator in validators) {
      validator.fold(() => null, (t) => errors.add(t));
    }
    return errors;
  }
}
