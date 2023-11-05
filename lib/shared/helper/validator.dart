// import 'package:fpdart/fpdart.dart';
// import 'package:sharewithme/shared/helper/i_validator.dart';

// class Validator {
//   static String? validate(List<IValidator> validators) {
//     var error = '';
//     for (var validator in validators) {
//       validator.run().toOption().fold(
//         () => null,
//         (t) {
//           error = t;
//         },
//       );
//     }
//     return error;
//   }
// }

// // class IsEmptyValidate extends IValidator {
// //   static String isEmpty(String value) {

// //   }
// //   @override
// //   String run() {
// //     ddd();
// //   }
// // }
// // class Validator {
// //   String value;

// //   Validator._(this.value);

// //   factory Validator.nameValidator(Strng?){

// //   }
// //   static String? nameValidator(String? value) {
// //     emptyCheck(value!);
// //   }

// //   static String? mailValidator(String? value) {
// //     emptyCheck(value!);
// //     validMail(value);
// //   }

// //   static String? validMail(String value) {
// //     RegExp schoolEmailRegex = RegExp(
// //       r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
// //     );

// //     if (schoolEmailRegex.hasMatch(value)) {
// //       return null;
// //     } else {
// //       return "Lütfen geçerli formatta giriniz.";
// //     }
// //   }

// //   static String? emptyCheck(String value) {
// //     if (value.isEmpty) {
// //       return "Bu alan boş olamaz";
// //     }
// //     return null;
// //   }
// // }
