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
  final TextEditingController _descriptionController = TextEditingController();

  final List<TextEditingController> _positionControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _ctcControllers = [TextEditingController()];

  String? _selectedFormId;
  String? _selectedAdminId;
  DateTime? _selectedDeadline;

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
    // Load admin users
    context.read<AuthCubit>().getAllAdmins();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
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

          setState(() {
            _uploadedJDFileIds.add(fileId);
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading files: $e")),
      );
      rethrow; // Rethrow to handle in the calling method
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

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDeadline = selectedDateTime;
        });
      }
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "Select Date & Time";
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _createNewCompany() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedFormId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a form")),
        );
        return;
      }

      if (_selectedAdminId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a provider")),
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
        try {
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

          // Clear previous uploaded file IDs
          _uploadedJDFileIds.clear();

          // Upload files
          await _uploadJDFiles();

          // Close loading dialog
          Navigator.of(context).pop();
        } catch (e) {
          // Close loading dialog if it's showing
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error uploading files: $e")),
          );
          return;
        }
      }

      // Create company with uploaded file IDs
      context.read<CompanyCubit>().createCompany(
            name: _nameController.text,
            positions: positions,
            ctc: ctcs,
            location: _locationController.text.isEmpty
                ? null
                : _locationController.text,
            description: _descriptionController.text.isEmpty
                ? null
                : _descriptionController.text,
            floatBy: _selectedAdminId!,
            eligibleBatchesIds: _selectedBatchesIds,
            formId: _selectedFormId!,
            jdFiles: _uploadedJDFileIds,
            deadline: _selectedDeadline,
          );
    }
  }

  // Add a method to clear form data
  void _clearForm() {
    setState(() {
      // Clear text controllers
      _nameController.clear();
      _locationController.clear();
      _descriptionController.clear();

      // Clear position and CTC controllers
      for (var controller in _positionControllers) {
        controller.clear();
      }
      for (var controller in _ctcControllers) {
        controller.clear();
      }

      // Reset other fields
      _selectedFormId = null;
      _selectedAdminId = null;
      _selectedDeadline = null;
      _selectedBatchesIds.clear();
      _selectedJDFiles.clear();
      _uploadedJDFileIds.clear();

      // Reset form validation
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Create Company",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            context.read<AuthCubit>().checkAuthStatus(),
            Navigator.of(context).pop()
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: _createNewCompany,
              icon: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is CompanyCreated) {
            // Clear form data on successful creation
            _clearForm();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Company created successfully!")),
            );
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

                  // Deadline field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Application Deadline",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selectDateTime,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDateTime(_selectedDeadline),
                                  style: TextStyle(
                                    color: _selectedDeadline != null
                                        ? Colors.black87
                                        : Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Replace the provider text field with a dropdown
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UsersListLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropDown(
                              label: "Select Provider",
                              isRequired: true,
                              dropDownItemsList:
                                  state.users.map((user) => user.name).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  final selectedUser = state.users.firstWhere(
                                    (user) => user.name == value,
                                  );
                                  setState(() {
                                    _selectedAdminId = selectedUser.id;
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      } else if (state is AuthError) {
                        return Text("Error: ${state.message}");
                      }
                      return const Text("Failed to load providers");
                    },
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
                        if (state.forms.isEmpty) {
                          return InkWell(
                            onTap: _navigateToCreateForm,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.note_alt_outlined,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "No forms found",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "Tap to create",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropDown(
                                    label: "Select Form",
                                    isRequired: true,
                                    dropDownItemsList: state.forms
                                        .map((form) => form.name)
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        final selectedForm =
                                            state.forms.firstWhere(
                                          (form) => form.name == value,
                                        );
                                        setState(() {
                                          _selectedFormId = selectedForm.id;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (_selectedFormId != null)
                                  IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        DisplayFormPage.route(_selectedFormId!),
                                      );
                                    },
                                  ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selectedFormId = null;
                                });
                                _navigateToCreateForm();
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Create Custom Form"),
                            ),
                          ],
                        );
                      } else if (state is form_cubit.FormError) {
                        return Text("Error: ${state.error}");
                      }
                      return const Text("Failed to load forms");
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
                  // const Text(
                  //   "Job Description Files",
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),

                  // Use the enhanced FileUploadField for JD files
                  FileUploadField(
                    label: "Job Description Files",
                    fileCount: 0, // Unlimited files
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedJDFiles.clear(); // Clear previous selection
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
