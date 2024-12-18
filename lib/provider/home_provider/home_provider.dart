import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmail/model/mail_model.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../api/database/databse_helper.dart';
import '../../api/google_api_service.dart';
import '../../model/file_model.dart';
import 'file_provider.dart';

class MailNotifier extends StateNotifier<List<MailModel>> {
  final DatabaseHelper _dbHelper;
  Ref ref;

  // Constructor: Initialize with database data
  MailNotifier(this._dbHelper,this.ref) : super([]) {
    // _loadMailsFromDB();
  }

  // Load mails from the database and update state
  Future<void> _loadMailsFromDB() async {
    final mails = await _dbHelper.fetchAllMails(); // Load data from DB
    state = mails; // Update state
  }

  // Add a new mail to both state and database
  Future<void> addMail(MailModel mail) async {

    final id = await _dbHelper.insertMail(mail); // Insert into DB
    final newMail = mail.copyWith(id: id); // Get the new mail with ID
    state = [...state, newMail]; // Update state
  }

  // Remove a mail from both state and database
  Future<void> removeMail(int mailId) async {
    await _dbHelper.deleteMail(mailId); // Remove from DB
    state = [
      for (final mail in state)
        if (mail.id != mailId) mail,
    ];
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      // final currentList = ref.read(fileProvider);
      // ref.read(fileProvider.notifier).state = [
      //   ...currentList, // Spread the existing list
      //   FileModel(name: file.name, path: file.path), // Add the new file
      // ];

      ref.read(fileProvider.notifier).addFile
        (FileModel(name: file.name, path: file.path));

    } else {
      print('ERRRROOO');
    }
  }

  sendMail(MailModel mail) async {
    print(mail);

    final user = await GoogleAuthApi.signIn();

    if(user == null) return;

    final email = user.email; //Your Email;
    final auth = await user.authentication;
    final token = auth.accessToken!; //Your Email's token;

    final smtpServer = gmailSaslXoauth2(email, token);
    // Creating the Gmail server

    final file = File(mail.attachment!);

    // Create our email message.
    final message = Message()
      ..from = Address(email)
      ..recipients.add(mail.email) //recipent email
      ..attachments.add(FileAttachment(file))
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = mail.subject //subject of the email
      ..text = mail.body; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport'); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n$e'); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }

  }

}

final mailProvider = StateNotifierProvider<MailNotifier, List<MailModel>>((ref) {
  final dbHelper = DatabaseHelper.instance;
  return MailNotifier(dbHelper,ref);
});


