part of 'models.dart';

class RequestModel {
  final String id;
  final String userId;
  final RequestType type;
  final Map<String, dynamic> data;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? approvedBy;
  final String? rejectedBy;
  final String? rejectionReason;

  RequestModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.data,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.approvedBy,
    this.rejectedBy,
    this.rejectionReason,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: RequestType.values.firstWhere(
        (e) => e.toString() == 'RequestType.${json['type']}',
      ),
      data: json['data'] as Map<String, dynamic>,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      approvedBy: json['approvedBy'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString().split('.').last,
      'data': data,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'approvedBy': approvedBy,
      'rejectedBy': rejectedBy,
      'rejectionReason': rejectionReason,
    };
  }

  RequestModel copyWith({
    String? id,
    String? userId,
    RequestType? type,
    Map<String, dynamic>? data,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
  }) {
    return RequestModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      data: data ?? this.data,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      rejectedBy: rejectedBy ?? this.rejectedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}
