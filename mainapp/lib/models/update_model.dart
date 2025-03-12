// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class UpdateModel {
  final String companyId;
  final String update;
  final Priority priority;
  UpdateModel({
    required this.companyId,
    required this.update,
    required this.priority,
  });

  UpdateModel copyWith({
    String? companyId,
    String? update,
    Priority? priority,
  }) {
    return UpdateModel(
      companyId: companyId ?? this.companyId,
      update: update ?? this.update,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'update': update,
      'priority': priority.name,
    };
  }

  factory UpdateModel.fromMap(Map<String, dynamic> map) {
    return UpdateModel(
      companyId: map['companyId'] as String,
      update: map['update'] as String,
      priority: Priority.values
          .firstWhere((element) => element.name == map['priority'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateModel.fromJson(String source) =>
      UpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UpdateModel(companyId: $companyId, update: $update, priority: $priority)';

  @override
  bool operator ==(covariant UpdateModel other) {
    if (identical(this, other)) return true;

    return other.companyId == companyId &&
        other.update == update &&
        other.priority == priority;
  }

  @override
  int get hashCode => companyId.hashCode ^ update.hashCode ^ priority.hashCode;
}
