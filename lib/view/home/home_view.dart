import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../api/google_api_service.dart';
import 'home_widget/button.dart';
import 'home_widget/textfield.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  testSend() async {

    print('ARSHAD');

    // await GoogleAuthApi.signOut();
    // return;


    final user = await GoogleAuthApi.signIn();

    if(user == null) return;

    final email = user.email; //Your Email;
    final auth = await user.authentication;
    final token = auth.accessToken!; //Your Email's token;

    final smtpServer = gmailSaslXoauth2(email, token);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(email)
      ..recipients.add('mdarshadkp786@gmail.com') //recipent email
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport'); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n$e'); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  signOut() async {
    await GoogleAuthApi.signOut();
    print('logout success');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('Jobmail'),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CustomTextField(label: 'Email:'),
              const CustomTextField(label: 'Subject:'),
              const CustomTextField(label: 'Mail:',maxLines: 5,),
              SecondaryButton(onTap: testSend),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minimumSize: const Size(50, 35)
                ),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
          
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    print('ArSHAd');
                    print(file);
                  } else {
                    // User canceled the picker
                  }
                },
                child: const SizedBox(
                  height: 35,
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.upload),
                      Text('attachment'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Center(
                child: MainButton(onTap: testSend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
