import 'package:flutter/material.dart';
import 'package:mainapp/custom/widgets/app_bar.dart';

class ChangeConfiguration extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const ChangeConfiguration(),
      );

  const ChangeConfiguration({super.key});

  @override
  State<ChangeConfiguration> createState() => _ChangeConfigurationState();
}

class _ChangeConfigurationState extends State<ChangeConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change App Configurations"),
      body: Column(),
      
    );
  }
}
