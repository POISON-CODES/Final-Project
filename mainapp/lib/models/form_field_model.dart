// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'models.dart';

enum FieldType { text, dropdown, file, multiselect }

class FormFieldModel {
  final String label;
  final FieldType fieldType;
  final bool? obscureText;
  final TextInputType? textInputType;
  final bool? enabled;
  final List<String>? dropDownItemsList;
  final int? fileCount;
  final bool isRequired;

  FormFieldModel({
    required this.label,
    required this.fieldType,
    this.obscureText,
    this.textInputType,
    this.enabled,
    this.dropDownItemsList,
    this.fileCount,
    this.isRequired = false,
  });

  FormFieldModel copyWith({
    String? label,
    FieldType? fieldType,
    bool? obscureText,
    TextInputType? textInputType,
    bool? enabled,
    List<String>? dropDownItemsList,
    int? fileCount,
    bool? isRequired,
  }) {
    return FormFieldModel(
      label: label ?? this.label,
      fieldType: fieldType ?? this.fieldType,
      obscureText: obscureText ?? this.obscureText,
      textInputType: textInputType ?? this.textInputType,
      enabled: enabled ?? this.enabled,
      dropDownItemsList: dropDownItemsList ?? this.dropDownItemsList,
      fileCount: fileCount ?? this.fileCount,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'fieldType': fieldType.name,
      'obscureText': obscureText,
      'textInputType': textInputType?.index,
      'enabled': enabled,
      'dropDownItemsList': dropDownItemsList,
      'fileCount': fileCount,
      'isRequired': isRequired,
    };
  }

  factory FormFieldModel.fromMap(Map<String, dynamic> map) {
    return FormFieldModel(
      label: map['label'] as String,
      fieldType: FieldType.values.byName(map['fieldType']),
      obscureText: map['obscureText'] as bool?,
      textInputType: map['textInputType'] != null
          ? TextInputType.values[map['textInputType']]
          : null,
      enabled: map['enabled'] as bool?,
      dropDownItemsList: map['dropDownItemsList'] != null
          ? List<String>.from(map['dropDownItemsList'])
          : null,
      fileCount: map['fileCount'] as int?,
      isRequired: map['isRequired'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormFieldModel.fromJson(String source) =>
      FormFieldModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FormFieldModel(label: $label, fieldType: $fieldType, obscureText: $obscureText, textInputType: $textInputType, enabled: $enabled, dropDownItemsList: $dropDownItemsList, fileCount: $fileCount, isRequired: $isRequired)';
  }

  @override
  bool operator ==(covariant FormFieldModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other.label == label &&
        other.fieldType == fieldType &&
        other.obscureText == obscureText &&
        other.textInputType == textInputType &&
        other.enabled == enabled &&
        listEquals(other.dropDownItemsList, dropDownItemsList) &&
        other.fileCount == fileCount &&
        other.isRequired == isRequired;
  }

  @override
  int get hashCode {
    return label.hashCode ^
        fieldType.hashCode ^
        obscureText.hashCode ^
        textInputType.hashCode ^
        enabled.hashCode ^
        dropDownItemsList.hashCode ^
        fileCount.hashCode ^
        isRequired.hashCode;
  }
}
