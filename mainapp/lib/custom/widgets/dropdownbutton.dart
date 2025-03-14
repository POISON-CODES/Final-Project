part of 'custom_global_widgets.dart';

class CustomDropDown extends FormFields {
  final void Function(String?) onChanged;

  const CustomDropDown({
    super.key,
    super.fieldType = FieldType.dropdown,
    super.isRequired = false,
    required super.label,
    required super.dropDownItemsList,
    required this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 400,
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
