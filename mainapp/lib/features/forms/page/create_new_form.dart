part of 'form_pages.dart';

class CreateFormPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (_) => const CreateFormPage());
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  TextEditingController _companyNameController = TextEditingController();
  List<FormFields> _formList = [];
  List<dynamic> _controllersList = [];

  void _showTextFieldDialog() {
    TextEditingController _newFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Field"),
          content: TextField(
            controller: _newFieldController,
            decoration: InputDecoration(labelText: "Field Name"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                setState(() {
                  _controllersList.add(_newFieldController);
                  _formList.add(CustomFormField(
                    controller: _newFieldController,
                    label: _newFieldController.text,
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDropdownFieldDialog() {
    TextEditingController _newFieldController = TextEditingController();
    TextEditingController _optionController = TextEditingController();
    List<String> dropdownItems = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add New Dropdown Field",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _newFieldController,
                      decoration: InputDecoration(labelText: "Field Name"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _optionController,
                      decoration: InputDecoration(labelText: "Add Option"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        if (_optionController.text.isNotEmpty) {
                          setDialogState(() {
                            dropdownItems.add(_optionController.text);
                            _optionController.clear();
                          });
                        }
                      },
                      child: Text("Add Option"),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      children: dropdownItems
                          .map(
                            (item) => Chip(
                              label: Text(item),
                              onDeleted: () {
                                setDialogState(() {
                                  dropdownItems.remove(item);
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Add"),
                          onPressed: () {
                            if (_newFieldController.text.isNotEmpty &&
                                dropdownItems.isNotEmpty) {
                              setState(() {
                                _formList.add(
                                  CustomDropDown(
                                    dropDownItemsList: dropdownItems,
                                    onChanged: (String? newValue) {
                                      _newFieldController.text = newValue ?? '';
                                    },
                                    label: _newFieldController.text,
                                  ),
                                );
                              });
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showFileUploadDialog() {
    TextEditingController _newFieldController = TextEditingController();
    TextEditingController _fileCountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Field"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _newFieldController,
                decoration: InputDecoration(labelText: "Field Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _fileCountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Number of Files",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                setState(() {
                  _controllersList.add(_newFieldController);
                  _formList.add(FileUploadField(
                    label: _newFieldController.text,
                    fileCount: _fileCountController.text.isNotEmpty
                        ? int.parse(_fileCountController.text)
                        : 1,
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createForm() {
    if (_companyNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form title cannot be empty")),
      );
      return;
    }

    List<FormFieldModel> formFields = _formList.map((field) {
      return FormFieldModel(
        label: field.label, // Assuming label is stored in _formList
        fieldType: field.fieldType, // Assuming fieldType is stored in _formList
        obscureText: field.obscureText,
        textInputType: field.textInputType,
        enabled: field.enabled,
        dropDownItemsList: field.dropDownItemsList,
        fileCount: field.fileCount,
        isRequired: field.isRequired,
      );
    }).toList();

    // Convert to JSON for storage
    Map<String, dynamic> formJson = {
      "id": "form_${DateTime.now().millisecondsSinceEpoch}",
      "title": _companyNameController.text,
      "fields": formFields.map((e) => e.toMap()).toList(),
      "createdAt": DateTime.now().toIso8601String(),
    };

    print(jsonEncode(formJson)); // Replace with actual database storage logic

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Form Created Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            CustomFormField(
              controller: _companyNameController,
              label: "Company Name",
            ),
            SizedBox(
              height: 10,
            ),
            ..._formList.map((field) => Column(
                  children: [
                    field,
                    SizedBox(height: 10),
                  ],
                )),
          ],
        )),
      ),
      appBar: CustomAppBar(
        title: "Create Form",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: _createForm,
              icon: Icon(Icons.check),
            ),
          )
        ],
      ),
      floatingActionButton: customFloatingActionButton(
        context: context,
        children: [
          CustomFABChild(
            label: "TextField",
            onTap: () {
              _showTextFieldDialog();
            },
            icon: Icon(Icons.text_fields),
          ),
          CustomFABChild(
            label: "DropDown",
            onTap: () {
              _showDropdownFieldDialog();
            },
            icon: Icon(Icons.arrow_drop_down),
          ),
          CustomFABChild(
            label: "File Upload",
            onTap: () {
              _showFileUploadDialog();
            },
            icon: Icon(Icons.upload),
          ),
          CustomFABChild(
            label: "MultiSelect",
            onTap: () {},
            icon: Icon(Icons.check_box),
          ),
        ],
        mainIcon: Icons.add,
      ),
    );
  }
}
