part of 'custom_global_widgets.dart';

abstract class FormFields extends StatefulWidget {
  final String label;
  final FieldType fieldType;
  final bool? obscureText;
  final TextInputType? textInputType;
  final bool? enabled;
  final List<String>? dropDownItemsList;
  final int? fileCount;
  final bool isRequired;
  const FormFields(
      {super.key,
      required this.label,
      required this.fieldType,
      this.obscureText,
      this.textInputType,
      this.enabled,
      this.dropDownItemsList,
      this.fileCount,
      required this.isRequired});
}
