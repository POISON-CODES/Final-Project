part of 'company_pages.dart';

class CreateNewCompanyPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const CreateNewCompanyPage());
  const CreateNewCompanyPage({super.key});

  @override
  State<CreateNewCompanyPage> createState() => _CreateNewCompanyPageState();
}

class _CreateNewCompanyPageState extends State<CreateNewCompanyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<TextEditingController> _positionControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _ctcControllers = [TextEditingController()];

  String? _selectedFormId;

  // For batch selection
  final List<String> _selectedBatchesIds = [];

  // For JD files
  final List<PlatformFile> _selectedJDFiles = [];
  final List<String> _uploadedJDFileIds = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Load configurations and forms for selection
    context.read<ConfigurationCubit>().getAllConfigurations();
    context.read<form_cubit.FormCubit>().getAllForms();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _providerController.dispose();
    _descriptionController.dispose();

    for (var controller in _positionControllers) {
      controller.dispose();
    }

    for (var controller in _ctcControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addPositionCTCFields() {
    setState(() {
      _positionControllers.add(TextEditingController());
      _ctcControllers.add(TextEditingController());
    });
  }

  void _removePositionCTCFields(int index) {
    if (_positionControllers.length > 1) {
      setState(() {
        _positionControllers[index].dispose();
        _ctcControllers[index].dispose();
        _positionControllers.removeAt(index);
        _ctcControllers.removeAt(index);
      });
    }
  }

  Future<void> _uploadJDFiles() async {
    try {
      for (var file in _selectedJDFiles) {
        if (file.bytes != null) {
          final String fileId = await context.read<CompanyCubit>().uploadJDFile(
                file.bytes!,
                file.name,
                file.extension == 'pdf'
                    ? 'application/pdf'
                    : 'application/msword',
              );

          _uploadedJDFileIds.add(fileId);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading files: $e")),
      );
    }
  }

  void _navigateToCreateForm() async {
    // Navigate to the form creation page using route method from CreateFormPage
    final result = await Navigator.of(context).push(CreateFormPage.route());

    // Refresh forms list after returning from form creation
    if (result == true) {
      context.read<form_cubit.FormCubit>().getAllForms();
    }
  }

  Future<void> _createNewCompany() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedFormId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a form")),
        );
        return;
      }

      // Extract position and CTC values
      final List<String> positions = _positionControllers
          .map((controller) => controller.text)
          .where((text) => text.isNotEmpty)
          .toList();

      final List<String> ctcs = _ctcControllers
          .map((controller) => controller.text)
          .where((text) => text.isNotEmpty)
          .toList();

      if (positions.isEmpty ||
          ctcs.isEmpty ||
          positions.length != ctcs.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please provide valid positions and CTCs")),
        );
        return;
      }

      // Validate batches selection
      if (_selectedBatchesIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select at least one batch")),
        );
        return;
      }

      // Upload JD files if any
      if (_selectedJDFiles.isNotEmpty) {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Uploading JD Files..."),
                ],
              ),
            );
          },
        );

        // Upload files
        await _uploadJDFiles();

        // Close loading dialog
        Navigator.of(context).pop();
      }

      // Create company using the cubit
      context.read<CompanyCubit>().createCompany(
            name: _nameController.text,
            positions: positions,
            ctc: ctcs,
            location: _locationController.text.isEmpty
                ? null
                : _locationController.text,
            provider: _providerController.text,
            eligibleBatchesIds: _selectedBatchesIds,
            formId: _selectedFormId!,
            jdFiles: _uploadedJDFileIds,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Company", actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: _createNewCompany,
            icon: const Icon(Icons.check),
          ),
        ),
      ]),
      body: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is CompanyCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Company created successfully!")),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    controller: _nameController,
                    label: 'Company Name',
                    isRequired: true,
                    fieldType: FieldType.text,
                  ),
                  const SizedBox(height: 16),

                  CustomFormField(
                    controller: _descriptionController,
                    label: 'Company Description',
                    isRequired: false,
                    fieldType: FieldType.text,
                    textInputType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 16),

                  CustomFormField(
                    controller: _locationController,
                    label: 'Location',
                    isRequired: false,
                    fieldType: FieldType.text,
                  ),
                  const SizedBox(height: 16),

                  CustomFormField(
                    controller: _providerController,
                    label: 'Provider',
                    isRequired: true,
                    fieldType: FieldType.text,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Positions and CTCs",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dynamic position and CTC fields
                  for (int i = 0; i < _positionControllers.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomFormField(
                              controller: _positionControllers[i],
                              label: 'Position ${i + 1}',
                              isRequired: true,
                              fieldType: FieldType.text,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: CustomFormField(
                              controller: _ctcControllers[i],
                              label: 'CTC ${i + 1}',
                              isRequired: true,
                              fieldType: FieldType.text,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _removePositionCTCFields(i),
                          ),
                        ],
                      ),
                    ),

                  TextButton.icon(
                    onPressed: _addPositionCTCFields,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Position"),
                  ),
                  const SizedBox(height: 16),

                  // Form selection
                  const Text(
                    "Select Application Form",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
                    builder: (context, state) {
                      if (state is form_cubit.FormLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is form_cubit.FormsList) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Select Form',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedFormId,
                              items: [
                                // Add all existing forms
                                ...state.forms.map((form) {
                                  return DropdownMenuItem<String>(
                                    value: form.id,
                                    child: Text(form.title),
                                  );
                                }).toList(),
                                // Add a custom option
                                if (state.forms.isNotEmpty)
                                  const DropdownMenuItem<String>(
                                    value: "create_new",
                                    child: Text("+ Create Custom Form"),
                                  ),
                              ],
                              onChanged: (value) {
                                if (value == "create_new") {
                                  // Reset selection and go to create form
                                  setState(() {
                                    _selectedFormId = null;
                                  });
                                  _navigateToCreateForm();
                                } else {
                                  setState(() {
                                    _selectedFormId = value;
                                  });
                                }
                              },
                              hint: const Text("Select a form"),
                            ),
                            if (state.forms.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextButton.icon(
                                  onPressed: _navigateToCreateForm,
                                  icon: const Icon(Icons.add),
                                  label: const Text("Create New Form"),
                                ),
                              ),
                          ],
                        );
                      } else if (state is form_cubit.FormError) {
                        return Text("Error: ${state.error}");
                      }

                      return const Text("No forms available");
                    },
                  ),

                  const SizedBox(height: 16),

                  // Eligible Batches Section
                  const Text(
                    "Eligible Batches",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Batch selection with SearchMultiSelectField
                  BlocBuilder<ConfigurationCubit, ConfigurationState>(
                    builder: (context, state) {
                      if (state is ConfigurationLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ConfigurationsLoaded) {
                        if (state.configurations.isEmpty) {
                          return const Text(
                              "No batches available. Please add configurations first.");
                        }

                        // Format batch information for display
                        List<String> batchOptions = [];
                        Map<String, String> batchIdToDisplayMap = {};

                        for (var config in state.configurations) {
                          String displayText =
                              "${config.department.name.toUpperCase()} - ${config.course} - ${config.specialization}";
                          batchOptions.add(displayText);
                          batchIdToDisplayMap[config.id] = displayText;

                          // Reverse mapping for selection
                          for (var entry in batchIdToDisplayMap.entries) {
                            if (entry.value == displayText) {
                              _selectedBatchesIds.remove(entry.key);
                            }
                          }
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MultiSelectField(
                              label: "Eligible Batches",
                              isRequired: true,
                              dropDownItemsList: batchOptions,
                              initialValues: _selectedBatchesIds
                                  .map((id) => batchIdToDisplayMap[id] ?? "")
                                  .toList(),
                              onChanged: (List<String> selectedDisplayValues) {
                                setState(() {
                                  // Clear previous selections
                                  _selectedBatchesIds.clear();

                                  // Add new selections by finding IDs from the display values
                                  for (var displayValue
                                      in selectedDisplayValues) {
                                    for (var entry
                                        in batchIdToDisplayMap.entries) {
                                      if (entry.value == displayValue) {
                                        _selectedBatchesIds.add(entry.key);
                                        break;
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      }

                      return const Text("Failed to load batches");
                    },
                  ),

                  const SizedBox(height: 16),

                  // JD Files Section
                  const Text(
                    "Job Description Files",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Use the enhanced FileUploadField for JD files
                  FileUploadField(
                    label: "Job Description Files",
                    fileCount: 0, // Unlimited files
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedJDFiles.clear();
                        _selectedJDFiles.addAll(files);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
