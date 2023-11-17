import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  static Future<void> sendEmail({required String email}) async {
    final Email emailObject = Email(
      body: applyCreatedMessage,
      subject: aboutApply,
      recipients: [email],
      isHTML: false,
    );

    return await FlutterEmailSender.send(emailObject);
  }

  static String get applyCreatedMessage =>
      "Başvurunuz tarafımıza ulaşmış olup, en kısa sürede dönüş sağlayacağız";
  static String get aboutApply => "About Apply";
}
