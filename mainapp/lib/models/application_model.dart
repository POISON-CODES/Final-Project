import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApplicationModel {
  final String id;
  final String userId;
  final String companyId;
  final String position;
  final ApplicationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> data;

  ApplicationModel({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.position,
    this.status = ApplicationStatus.pending,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'companyId': companyId,
      'position': position,
      'status': status.toString().split('.').last,
      'data': data,
    };
  }

  ApplicationModel copyWith({
    String? id,
    String? userId,
    String? companyId,
    String? position,
    ApplicationStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? data,
  }) {
    return ApplicationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      position: position ?? this.position,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      data: data ?? this.data,
    );
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      id: map['\$id'] ?? '',
      userId: map['userId'] ?? '',
      companyId: map['companyId'] ?? '',
      position: map['position'] ?? '',
      status: ApplicationStatus.values.firstWhere(
        (e) => e.toString() == 'ApplicationStatus.${map['status']}',
        orElse: () => ApplicationStatus.pending,
      ),
      createdAt: DateTime.parse(map['\$createdAt']),
      updatedAt: DateTime.parse(map['\$updatedAt']),
      data: map['data'] ?? {},
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationModel.fromJson(String source) =>
      ApplicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApplicationModel(id: $id, userId: $userId, companyId: $companyId, position: $position, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, data: $data)';
  }

  @override
  bool operator ==(covariant ApplicationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.companyId == companyId &&
        other.position == position &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        companyId.hashCode ^
        position.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        data.hashCode;
  }
}

enum ApplicationStatus {
  pending,
  shortlisted,
  rejected,
  selected,
}
