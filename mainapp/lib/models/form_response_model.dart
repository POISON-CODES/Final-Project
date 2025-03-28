part of 'models.dart';

class FormResponseModel {
  final String id;
  final String formId;
  final String userId;
  final Map<String, dynamic> responses;
  final List<Map<String, dynamic>> fileResponses;
  final DateTime submittedAt;

  FormResponseModel({
    required this.id,
    required this.formId,
    required this.userId,
    required this.responses,
    required this.fileResponses,
    required this.submittedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'form_id': formId,
      'user_id': userId,
      'responses': responses,
      'file_responses': fileResponses,
      'submitted_at': submittedAt.toIso8601String(),
    };
  }

  factory FormResponseModel.fromMap(Map<String, dynamic> map) {
    return FormResponseModel(
      id: map['\$id'] ?? '',
      formId: map['form_id'] ?? '',
      userId: map['user_id'] ?? '',
      responses: Map<String, dynamic>.from(map['responses'] ?? {}),
      fileResponses:
          List<Map<String, dynamic>>.from(map['file_responses'] ?? []),
      submittedAt: DateTime.parse(map['submitted_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FormResponseModel.fromJson(String source) =>
      FormResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
