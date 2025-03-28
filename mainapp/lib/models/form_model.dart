// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class FormModel {
  final String id;
  final String name;
  final String fields;
  final List responses;
  FormModel({
    required this.id,
    required this.name,
    required this.fields,
    required this.responses,
  });

  String get title => name;

  FormModel copyWith({
    String? id,
    String? name,
    String? fields,
    List? responses,
  }) {
    return FormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields ?? this.fields,
      responses: responses ?? this.responses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fields': fields,
      'responses': responses,
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['id'] as String,
      name: map['name'] as String,
      fields: map['fields'] as String,
      responses: List.from((map['responses'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromAppwrite(Document doc) {
    return FormModel(
      id: doc.$id,
      name: doc.data['name'] as String,
      fields: doc.data['fields'] as String,
      responses: List.from(doc.data['responses'] as List),
    );
  }

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormModel(id: $id, name: $name, fields: $fields, responses: $responses)';
  }

  @override
  bool operator ==(covariant FormModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        listEquals(other.fields, fields) &&
        listEquals(other.responses, responses);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ fields.hashCode ^ responses.hashCode;
  }
}
