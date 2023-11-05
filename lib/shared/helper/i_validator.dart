import 'package:fpdart/fpdart.dart';

abstract class IValidator<T> {
  bool validate(T value);
}

class StringValidator implements IValidator<String> {
  @override
  bool validate(String value) {
    return value.isNotEmpty.match(
      () => false,
      () => true,
    );
  }

  static StringValidator i = StringValidator();
}

class Validator {
  static bool validate(List<IValidator> validators, String value) {
    var validate = true;
    for (var validator in validators) {
      validate = validator.validate(value);
      if (!validate) {
        break;
      }
    }
    return validate;
  }
}
