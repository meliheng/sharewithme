import 'package:flutter_test/flutter_test.dart';
import 'package:sharewithme/shared/helper/i_validator.dart';

void main() {
  test(
    "validate is empty",
    () {
      final result = Validator.validate(
        [
          StringValidator(),
        ],
        "",
      );
      expect(result, false);
    },
  );
}
