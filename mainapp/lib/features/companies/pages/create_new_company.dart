import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewCompanyPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const CreateNewCompanyPage());
  const CreateNewCompanyPage({super.key});

  @override
  State<CreateNewCompanyPage> createState() => _CreateNewCompanyPageState();
}

class _CreateNewCompanyPageState extends State<CreateNewCompanyPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createNewCompany() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: 'Company Description', labelStyle: TextStyle()),
              ),
              ElevatedButton(
                onPressed: _createNewCompany,
                child: Text("SUBMIT"),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Company"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return {'LogOut', 'Settings'}.map(
                (String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                },
              ).toList();
            },
          )
        ],
      ),
    );
  }
}
