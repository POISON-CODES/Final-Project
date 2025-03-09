part of 'models.dart';

class File {
  final String name;
  final String type;
  final String size;
  final String id;
  File({
    required this.name,
    required this.type,
    required this.size,
    this.id = '',
  });

  File copyWith({
    String? name,
    String? type,
    String? size,
    String? id,
  }) {
    return File(
      name: name ?? this.name,
      type: type ?? this.type,
      size: size ?? this.size,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'size': size,
      'id': id,
    };
  }

  factory File.fromMap(Map<String, dynamic> map) {
    return File(
      name: map['name'] as String,
      type: map['type'] as String,
      size: map['size'] as String,
      id: map['id'] as String,
    );
  }

  factory File.fromPlatformFile(PlatformFile file) {
    return File(
      name: file.name,
      type: file.extension!,
      size: file.size.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory File.fromJson(String source) =>
      File.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'File(name: $name, type: $type, size: $size, id: $id)';
  }

  @override
  bool operator ==(covariant File other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.size == size &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ size.hashCode ^ id.hashCode;
  }
}
