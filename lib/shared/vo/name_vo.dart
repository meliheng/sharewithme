import 'package:sharewithme/export.dart';

class Name implements ValueObject<String> {
  @override
  final String value;
  Name._(this.value);
  Name get copy {
    return Name._(value);
  }

  factory Name.def() {
    return Name._('');
  }
  factory Name.create(String value) {
    return Name._(value);
  }
}
