import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Email Model
class MailModel {
  final int? id; // Optional for database auto-increment
  final String email;
  final String subject;
  final String body;
  final String? attachment;

  MailModel({
    this.id,
    required this.email,
    required this.subject,
    required this.body,
    this.attachment,
  });

  // Convert EmailModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'subject': subject,
      'body': body,
      'attachment': attachment,
    };
  }

  // Create EmailModel from Map
  factory MailModel.fromMap(Map<String, dynamic> map) {
    return MailModel(
      id: map['id'],
      email: map['email'],
      subject: map['subject'],
      body: map['body'],
      attachment: map['attachment'],
    );
  }

  // CopyWith method
  MailModel copyWith({
    int? id,
    String? email,
    String? subject,
    String? body,
    String? attachment,
  }) {
    return MailModel(
      id: id ?? this.id,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  String toString() {
    return 'MailModel(id: $id, email: $email, subject: $subject, body: $body, '
        'attachment: $attachment)';
  }
}


