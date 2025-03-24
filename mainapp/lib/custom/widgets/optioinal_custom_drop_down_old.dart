

import 'package:flutter/material.dart';
import 'package:mainapp/constants/constants.dart' show FieldType;
import 'package:mainapp/custom/widgets/custom_global_widgets.dart' show FormFields;

class CustomDropDown extends FormFields {
  final void Function(String?) onChanged;
  final String? initialValue;

  const CustomDropDown({
    super.key,
    super.fieldType = FieldType.dropDown as dynamic,
    super.isRequired = true,
    required super.label,
    required super.dropDownItemsList,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 400,
      value: widget.initialValue,
      decoration: InputDecoration(
        label: Text(" ${widget.label} "),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintText: widget.label,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      items: widget.dropDownItemsList!
          .map(
            (val) => DropdownMenuItem(
              value: val,
              child: Text(val),
            ),
          )
          .toList(),
      onChanged: widget.onChanged,
    );
  }
}
