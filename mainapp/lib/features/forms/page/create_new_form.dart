part of 'form_pages.dart';

class CreateFormPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (_) => const CreateFormPage());
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  final TextEditingController _titleController =
      TextEditingController(text: "Untitled Form");

  final List<FormFields> _formList = [];
  final List<dynamic> _controllersList = [];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showTextFieldDialog() {
    TextEditingController newFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Field"),
          content: TextField(
            controller: newFieldController,
            decoration: const InputDecoration(labelText: "Field Name"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  _controllersList.add(newFieldController);
                  _formList.add(CustomFormField(
                    controller: newFieldController,
                    label: newFieldController.text,
                  ));
                  newFieldController.text = '';
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
    TextEditingController newFieldController = TextEditingController();
    TextEditingController optionController = TextEditingController();
    List<String> dropdownItems = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Add New Dropdown Field",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: newFieldController,
                      decoration:
                          const InputDecoration(labelText: "Field Name"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: optionController,
                      decoration:
                          const InputDecoration(labelText: "Add Option"),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        if (optionController.text.isNotEmpty) {
                          setDialogState(() {
                            dropdownItems.add(optionController.text);
                            optionController.clear();
                          });
                        }
                      },
                      child: const Text("Add Option"),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Add"),
                          onPressed: () {
                            if (newFieldController.text.isNotEmpty &&
                                dropdownItems.isNotEmpty) {
                              setState(() {
                                _formList.add(
                                  CustomDropDown(
                                    dropDownItemsList: dropdownItems,
                                    onChanged: (String? newValue) {
                                      newFieldController.text = newValue ?? '';
                                    },
                                    label: newFieldController.text,
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
    TextEditingController newFieldController = TextEditingController();
    TextEditingController fileCountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Field"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newFieldController,
                decoration: const InputDecoration(labelText: "Field Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: fileCountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Number of Files",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  _controllersList.add(newFieldController);
                  _formList.add(FileUploadField(
                    label: newFieldController.text,
                    fileCount: fileCountController.text.isNotEmpty
                        ? int.parse(fileCountController.text)
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

    Map<String, dynamic> formJson = {
      "id": "form_${DateTime.now().millisecondsSinceEpoch}",
      "titl": _titleController.text.isEmpty
          ? "Untitled Form"
          : _titleController.text,
      "fields": formFields.map((e) => e.toMap()).toList(),
      "createdAt": DateTime.now().toIso8601String(),
    };

    context.read<form_cubit.FormCubit>().createForm(
          title: _titleController.text,
          fields: formJson.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<form_cubit.FormCubit, form_cubit.FormState>(
      listener: (context, state) {
        if (state is form_cubit.FormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is form_cubit.FormCreate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Form created successfully!"),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is form_cubit.FormLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                CustomFormField(
                  controller: _titleController,
                  label: "Form Title",
                ),
                const SizedBox(height: 10),
                ..._formList.map((field) => Column(
                      children: [
                        field,
                        const SizedBox(height: 10),
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
                  icon: const Icon(Icons.check),
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
                icon: const Icon(Icons.text_fields),
              ),
              CustomFABChild(
                label: "DropDown",
                onTap: () {
                  _showDropdownFieldDialog();
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
              CustomFABChild(
                label: "File Upload",
                onTap: () {
                  _showFileUploadDialog();
                },
                icon: const Icon(Icons.upload),
              ),
              CustomFABChild(
                label: "MultiSelect",
                onTap: () {},
                icon: const Icon(Icons.check_box),
              ),
            ],
            mainIcon: Icons.add,
          ),
        );
      },
    );
  }
}
