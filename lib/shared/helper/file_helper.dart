import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static TaskEither<Unit, File> pickImage() {
    return TaskEither(
      () async {
        final pickerFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickerFile != null) {
          File file = File(pickerFile.path);
          return Either.right(file);
        } else {
          return Either.left(unit);
        }
      },
    );
  }
}
