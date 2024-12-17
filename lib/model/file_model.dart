
class FileModel {
  final String? name;
  final String? path;

  FileModel({this.name, this.path});

  // Convert FileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
    };
  }

  // Create FileModel from JSON
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'],
      path: json['path'],
    );
  }
}
