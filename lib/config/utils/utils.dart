import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final fileProvider = StateProvider<String>((ref) {
//   String path = ref.watch(filePickerProvider!!);
//   return path;
// });

// final filePickerProvider = FutureProvider<File?>((ref) async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//   if (result != null) {
//     return File(result.files.single.path!); // Return the selected file
//   } else {
//     return null; // No file picked
//   }
// });

Future<void> filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    print('ARSHAD');
    PlatformFile fileT = result.files.first;
    print(file.path);
    print(fileT.path);
    print(fileT.name);
    // print();
  } else {
    print('ERRRROOOORRRR!!!');
    // User canceled the picker
  }
}