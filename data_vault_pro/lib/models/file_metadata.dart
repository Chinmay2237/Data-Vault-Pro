class FileMetadata {
  final int? id;
  final String path;
  final String name;
  final int size;
  final String type;
  final DateTime createdAt;

  FileMetadata({
    this.id,
    required this.path,
    required this.name,
    required this.size,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'size': size,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
