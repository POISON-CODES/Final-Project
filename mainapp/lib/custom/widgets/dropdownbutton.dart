part of 'custom_global_widgets.dart';

class CustomDropDown extends FormFields {
  final List<String> itemsList;
  final void Function(String?) onChanged;
  final String label;

  const CustomDropDown({
    super.key,
    required this.itemsList,
    required this.onChanged,
    required this.label,
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
      items: widget.itemsList
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
