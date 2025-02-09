part of 'custom_global_widgets.dart';

class CustomDropDown extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 400,
      decoration: InputDecoration(
        label: Text(" $label "),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      items: itemsList
          .map(
            (val) => DropdownMenuItem(
              value: val,
              child: Text(val),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
