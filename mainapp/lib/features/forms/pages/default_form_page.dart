import 'package:flutter/material.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';

class DefaultFormPage extends StatelessWidget {
  const DefaultFormPage({super.key});

  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const DefaultFormPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Default Form",
      ),
      body: const Center(
        child: Text("Default Form Page"),
      ),
    );
  }
}
