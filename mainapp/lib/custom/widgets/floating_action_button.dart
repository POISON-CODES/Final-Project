import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDial customFloatingActionButton({
  required BuildContext context,
  required List<CustomFABChild> children,
  required IconData mainIcon,
}) {
  return SpeedDial(
    spaceBetweenChildren: 10,
    spacing: 10,
    overlayOpacity: 0,
    icon: mainIcon,
    animatedIconTheme: IconThemeData(size: 22),
    backgroundColor: Colors.white,
    visible: true,
    curve: Curves.ease,
    children: children
        .map(
          (val) => SpeedDialChild(
            child: val.icon,
            onTap: val.onTap,
            label: val.label,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
          ),
        )
        .toList(),
  );
}

class CustomFABChild {
  final String label;
  final void Function()? onTap;
  final Icon icon;
  CustomFABChild({
    required this.label,
    required this.onTap,
    required this.icon,
  });
}
