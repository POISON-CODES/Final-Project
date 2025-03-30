// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class CompanyModel {
  final String id;
  final String name;
  final List<String> positions;
  final List<String> ctc;
  final String? location;
  final String? description;
  final String floatBy;
  final List<String> eligibleBatchesIds;
  final String formId;
  final List<String> jdFiles;
  final DateTime? deadline;
  final DateTime floatTime;
  final List<String>? updates;
  final List<String>? students;

  CompanyModel({
    required this.id,
    required this.name,
    required this.positions,
    required this.ctc,
    this.location,
    this.description,
    required this.floatBy,
    required this.eligibleBatchesIds,
    required this.formId,
    this.jdFiles = const [],
    this.deadline,
    DateTime? floatTime,
    this.updates,
    this.students,
  }) : floatTime = floatTime ?? DateTime.now();

  CompanyModel copyWith({
    String? id,
    String? name,
    List<String>? positions,
    List<String>? ctc,
    String? location,
    String? description,
    String? floatBy,
    List<String>? eligibleBatchesIds,
    String? formId,
    List<String>? jdFiles,
    DateTime? deadline,
    DateTime? floatTime,
    List<String>? updates,
    List<String>? students,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      positions: positions ?? this.positions,
      ctc: ctc ?? this.ctc,
      location: location ?? this.location,
      description: description ?? this.description,
      floatBy: floatBy ?? this.floatBy,
      eligibleBatchesIds: eligibleBatchesIds ?? this.eligibleBatchesIds,
      formId: formId ?? this.formId,
      jdFiles: jdFiles ?? this.jdFiles,
      deadline: deadline ?? this.deadline,
      floatTime: floatTime ?? this.floatTime,
      updates: updates ?? this.updates,
      students: students ?? this.students,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'positions': positions,
      'ctc': ctc,
      'location': location,
      'description': description,
      'floatBy': floatBy,
      'eligibleBatchesIds': eligibleBatchesIds,
      'formId': formId,
      'jdFiles': jdFiles,
      'deadline': deadline?.toIso8601String(),
      'floatTime': floatTime.toIso8601String(),
      'updates': updates,
      'students': students,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as String,
      name: map['name'] as String,
      positions: List<String>.from((map['positions'] as List<String>)),
      ctc: List<String>.from((map['ctc'] as List<String>)),
      location: map['location'] != null ? map['location'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      floatBy: map['floatBy'] as String,
      eligibleBatchesIds:
          List<String>.from((map['eligibleBatchesIds'] as List<String>)),
      formId: map['formId'] as String,
      jdFiles: map['jdFiles'] != null
          ? List<String>.from((map['jdFiles'] as List))
          : const [],
      deadline: map['deadline'] != null
          ? DateTime.parse(map['deadline'] as String)
          : null,
      floatTime: map['floatTime'] != null
          ? DateTime.parse(map['floatTime'] as String)
          : DateTime.now(),
      updates: map['updates'] != null
          ? List<String>.from((map['updates'] as List))
          : null,
      students: map['students'] != null
          ? List<String>.from((map['students'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanyModel(id: $id, name: $name, positions: $positions, ctc: $ctc, location: $location, description: $description, floatBy: $floatBy, eligibleBatchesIds: $eligibleBatchesIds, formId: $formId, jdFiles: $jdFiles, deadline: $deadline, floatTime: $floatTime, updates: $updates, students: $students)';
  }

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        listEquals(other.positions, positions) &&
        listEquals(other.ctc, ctc) &&
        other.location == location &&
        other.description == description &&
        other.floatBy == floatBy &&
        listEquals(other.eligibleBatchesIds, eligibleBatchesIds) &&
        other.formId == formId &&
        listEquals(other.jdFiles, jdFiles) &&
        other.deadline == deadline &&
        other.floatTime == floatTime &&
        listEquals(other.updates, updates) &&
        listEquals(other.students, students);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        positions.hashCode ^
        ctc.hashCode ^
        location.hashCode ^
        description.hashCode ^
        floatBy.hashCode ^
        eligibleBatchesIds.hashCode ^
        formId.hashCode ^
        jdFiles.hashCode ^
        deadline.hashCode ^
        floatTime.hashCode ^
        updates.hashCode ^
        students.hashCode;
  }
}
