// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class CompanyModel {
  final String id;
  final String name;
  final List<String> positions;
  final List<String> ctc;
  final String? location;
  final String provider;
  final List<String> eligibleBatchesIds;
  final String formId;
  CompanyModel({
    required this.id,
    required this.name,
    required this.positions,
    required this.ctc,
    this.location,
    required this.provider,
    required this.eligibleBatchesIds,
    required this.formId,
  });

  CompanyModel copyWith({
    String? id,
    String? name,
    List<String>? positions,
    List<String>? ctc,
    String? location,
    String? provider,
    List<String>? eligibleBatchesIds,
    String? formId,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      positions: positions ?? this.positions,
      ctc: ctc ?? this.ctc,
      location: location ?? this.location,
      provider: provider ?? this.provider,
      eligibleBatchesIds: eligibleBatchesIds ?? this.eligibleBatchesIds,
      formId: formId ?? this.formId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'positions': positions,
      'ctc': ctc,
      'location': location,
      'provider': provider,
      'eligibleBatchesIds': eligibleBatchesIds,
      'formId': formId,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as String,
      name: map['name'] as String,
      positions: List<String>.from((map['positions'] as List<String>)),
      ctc: List<String>.from((map['ctc'] as List<String>)),
      location: map['location'] != null ? map['location'] as String : null,
      provider: map['provider'] as String,
      eligibleBatchesIds:
          List<String>.from((map['eligibleBatchesIds'] as List<String>)),
      formId: map['formId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanyModel(id: $id, name: $name, positions: $positions, ctc: $ctc, location: $location, provider: $provider, eligibleBatchesIds: $eligibleBatchesIds, formId: $formId)';
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
        other.provider == provider &&
        listEquals(other.eligibleBatchesIds, eligibleBatchesIds) &&
        other.formId == formId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        positions.hashCode ^
        ctc.hashCode ^
        location.hashCode ^
        provider.hashCode ^
        eligibleBatchesIds.hashCode ^
        formId.hashCode;
  }
}
