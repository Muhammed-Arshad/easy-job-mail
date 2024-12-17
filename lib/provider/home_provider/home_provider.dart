import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmail/model/mail_model.dart';

import '../../api/database/databse_helper.dart';
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
    ]; // Update state
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
      // ref.read(provider)

      // ref.read(fileProvider.notifier).state.add(FileModel(name: file.name, path: file.path));
    } else {
      print('ERRRROOO');
    }
  }

}

// Provider for MailNotifier with database initialization
final mailProvider = StateNotifierProvider<MailNotifier, List<MailModel>>((ref) {
  final dbHelper = DatabaseHelper.instance; // Get database helper instance
  return MailNotifier(dbHelper,ref);
});

// final fileProvider = StateProvider<List<FileModel>>((ref){
//   return <FileModel>[];
// });


// final filePickerProvider = FutureProvider<PlatformFile?>((ref) async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//   if (result != null) {
//     PlatformFile file = result.files.first;
//     ref.read(fileProvider.notifier).state.add
//       (FileModel(name: file.name, path: file.path));
//     return file; // Return the selected file
//   } else {
//     return null; // No file picked
//   }
// });