import 'package:flutter/material.dart';
import 'package:mainapp/custom/widgets/app_bar.dart';
import 'package:mainapp/custom/widgets/floating_action_button.dart';
import 'package:mainapp/features/configurations/pages/create_configuration.dart';

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 20),
        child: customFloatingActionButton(
          onPress: () =>
              Navigator.of(context).push(CreateConfiguration.route()),
          context: context,
          children: [
            CustomFABChild(
                label: "Create Configuration",
                onTap: () =>
                    Navigator.of(context).push(CreateConfiguration.route()),
                icon: Icon(Icons.add)),
            CustomFABChild(
              label: "Coming Soon",
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Samajh nahi aara Coming Soon Bola toh"),
                ),
              ),
              icon: Icon(Icons.more_horiz),
            )
          ],
          mainIcon: Icons.add,
        ),
      ),
      appBar: CustomAppBar(title: "Change App Configurations"),
      body: Column(),
    );
  }
}
