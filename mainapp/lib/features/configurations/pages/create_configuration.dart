import 'package:flutter/material.dart';
import 'package:mainapp/constants/enums.dart';
import 'package:mainapp/custom/widgets/app_bar.dart';
import 'package:mainapp/custom/widgets/generic_form_field.dart';

class CreateConfiguration extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => CreateConfiguration());
  const CreateConfiguration({super.key});

  @override
  State<CreateConfiguration> createState() => _CreateConfigurationState();
}

class _CreateConfigurationState extends State<CreateConfiguration> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _courseController = TextEditingController();

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

  void _createConfiguration() {}

  final List<String> _departments =
      Department.values.map((val) => val.name.toUpperCase()).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Configuration',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField(
                  menuMaxHeight: 400,
                  decoration: InputDecoration(
                    label: Text(" Select a Department "),
                    hintText: "Select a Department",
                  ),
                  items: _departments
                      .map(
                        (val) => DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    print("Selected value: $newValue");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  courseController: _courseController,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  labelText: 'Course',
                  validator: null,
                ),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: _createConfiguration,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
