import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/database/databse_helper.dart';
import '../../model/file_model.dart';

final fileProvider = StateNotifierProvider<FileNotifier, List<FileModel>>((ref) {
  return FileNotifier();
});

class FileNotifier extends StateNotifier<List<FileModel>> {
  FileNotifier() : super([]) {
    loadFiles(); // Load files from local storage on init
  }

  // Load files from SharedPreferences
  Future<void> loadFiles() async {
    final files = await FileStorage.loadFiles();
    state = files;
  }

  // Add a new file and save the updated list
  Future<void> addFile(FileModel file) async {
    state = [...state, file]; // Update the state
    await FileStorage.saveFiles(state); // Save to SharedPreferences
  }
}



