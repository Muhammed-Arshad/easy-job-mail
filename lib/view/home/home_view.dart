


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmail/provider/home_provider/home_provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../api/google_api_service.dart';
import '../../config/utils/utils.dart';
import '../../model/mail_model.dart';
import 'home_widget/attachments.dart';
import 'home_widget/button.dart';
import 'home_widget/textfield.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController subjectCtrl = TextEditingController();
  final TextEditingController bodyCtrl = TextEditingController();

  test(){
    final newMail = MailModel(
      email: emailCtrl.text,
      subject: subjectCtrl.text,
      body: bodyCtrl.text,
      attachment:''
    );

    print(newMail);
    // ref.read(mailProvider.notifier).addMail(newMail);
  }

  testSend() async {

    print('ARSHAD');

    // await GoogleAuthApi.signOut();
    // return;
    // final file = File('path/to/your/file.pdf');

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
    // ..attachments.add(FileAttachment(file))
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
              CustomTextField(label: 'Email:',ctrl: emailCtrl,),

              CustomTextField(label: 'Subject:',ctrl: subjectCtrl,),

              CustomTextField(label: 'Mail:',maxLines: 5,ctrl: bodyCtrl,),

              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {

                  return SecondaryButton(
                      onTap: ref.read(mailProvider.notifier).pickFile);
                },
              ),

              const AttachmentsView(),

              const SizedBox(height: 40,),

              Center(
                child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      // final filePath = ref.watch(provider)
                      return MainButton(onTap: testSend);
                    },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
