part of 'models.dart';

class RequestModel {
  final String? id;
  final RequestType type;
  final RequestStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String? approvedBy;
  String? rejectedBy;
  final String? rejectionReason;

  RequestModel({
    this.id,
    required this.type,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.approvedBy,
    this.rejectedBy,
    this.rejectionReason,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['\$id'] as String?,
      type: RequestType.values.firstWhere(
        (e) => e.toString() == 'RequestType.${json['type']}',
      ),
      status: RequestStatus.values.firstWhere(
        (e) => e.toString() == 'RequestStatus.${json['status']}',
      ),
      createdAt: json['\$createdAt'] != null
          ? DateTime.parse(json['\$createdAt'] as String)
          : null,
      updatedAt: json['\$updatedAt'] != null
          ? DateTime.parse(json['\$updatedAt'] as String)
          : null,
      approvedBy: json['approvedBy'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'approvedBy': approvedBy ?? "",
      'rejectedBy': rejectedBy ?? "",
      'rejectionReason': rejectionReason ?? "",
    };
  }

  RequestModel copyWith({
    String? id,
    RequestType? type,
    RequestStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
  }) {
    return RequestModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      rejectedBy: rejectedBy ?? this.rejectedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}
