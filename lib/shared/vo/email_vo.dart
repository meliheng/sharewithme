import 'package:sharewithme/export.dart';

class Email implements ValueObject<String> {
  @override
  final String value;
  Email._(this.value);
  Email get copy {
    return Email._(value);
  }

  factory Email.def() {
    return Email._('');
  }
  factory Email.create(String value) {
    return Email._(value);
  }
  String? validate() {
    RegExp schoolEmailRegex = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );

    if (schoolEmailRegex.hasMatch(value)) {
      return null;
    } else {
      return "Lütfen geçerli formatta giriniz.";
    }
  }
}
