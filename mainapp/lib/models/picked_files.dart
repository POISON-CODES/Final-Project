// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'models.dart';

class CustomFile {
  final String name;
  final String type;
  final String size;
  final String id;
  final String? filePath; // Local path
  final String? remoteUrl; // Appwrite storage URL

  CustomFile({
    required this.name,
    required this.type,
    required this.size,
    required this.id,
    this.filePath,
    this.remoteUrl,
  });

  bool get isLocal => filePath != null;
  bool get isRemote => remoteUrl != null;
  io.File? get file => filePath != null ? io.File(filePath!) : null;

  factory CustomFile.fromPlatformFile(PlatformFile platformFile) {
    return CustomFile(
      name: platformFile.name,
      type: platformFile.extension ?? 'unknown',
      size: platformFile.size.toString(),
      id: platformFile.identifier ?? '',
      filePath: platformFile.path,
    );
  }

  CustomFile copyWith({
    String? name,
    String? type,
    String? size,
    String? id,
    String? filePath,
    String? remoteUrl,
  }) {
    return CustomFile(
      name: name ?? this.name,
      type: type ?? this.type,
      size: size ?? this.size,
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'size': size,
      'id': id,
      'filePath': filePath,
      'remoteUrl': remoteUrl,
    };
  }

  factory CustomFile.fromMap(Map<String, dynamic> map) {
    return CustomFile(
      name: map['name'] as String,
      type: map['type'] as String,
      size: map['size'] as String,
      id: map['id'] as String,
      filePath: map['filePath'] as String?,
      remoteUrl: map['remoteUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomFile.fromJson(String source) =>
      CustomFile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomFile(name: $name, type: $type, size: $size, id: $id, filePath: $filePath, remoteUrl: $remoteUrl)';
  }

  @override
  bool operator ==(covariant CustomFile other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.size == size &&
        other.id == id &&
        other.filePath == filePath &&
        other.remoteUrl == remoteUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ size.hashCode ^ id.hashCode ^ (filePath?.hashCode ?? 0) ^ (remoteUrl?.hashCode ?? 0);
  }
}
