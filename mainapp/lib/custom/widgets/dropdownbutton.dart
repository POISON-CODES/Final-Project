import 'package:flutter/material.dart';

DropdownButtonFormField<dynamic> customDropDown({
  required String selectedValue,
  required List items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: selectedValue,
    items: items.map((currency) {
      return DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
