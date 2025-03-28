part of 'form_pages.dart';

class DisplayFormPage extends StatefulWidget {
  final String formId;
  static MaterialPageRoute route(String formId) =>
      MaterialPageRoute(builder: (_) => DisplayFormPage(formId: formId));

  const DisplayFormPage({super.key, required this.formId});

  @override
  State<DisplayFormPage> createState() => _DisplayFormPageState();
}

class _DisplayFormPageState extends State<DisplayFormPage> {
  Map<String, dynamic> _formData = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, List<PlatformFile>> _fileData = {};
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadForm();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadForm() async {
    try {
      final formData =
          await context.read<form_cubit.FormCubit>().getForm(widget.formId);
      print(formData);
      setState(() {
        _formData = formData;
        _initializeControllers();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading form: $e')),
        );
      }
    }
  }

  void _initializeControllers() {
    final fields = _formData['fields'] as List<dynamic>;
    for (var field in fields) {
      final label = field['label'] as String;
      _controllers[label] = TextEditingController();
    }
  }

  Widget _buildFormField(Map<String, dynamic> field) {
    final label = field['label'] as String;
    final fieldType = field['fieldType'] as String;
    final isRequired = field['isRequired'] as bool? ?? false;

    switch (fieldType) {
      case 'text':
        return CustomFormField(
          controller: _controllers[label]!,
          label: label,
          isRequired: isRequired,
        );
      case 'dropdown':
        return CustomDropDown(
          label: label,
          isRequired: isRequired,
          dropDownItemsList:
              List<String>.from(field['dropDownItemsList'] ?? []),
          onChanged: (value) => _controllers[label]!.text = value ?? '',
        );
      case 'file':
        return FileUploadField(
          label: label,
          isRequired: isRequired,
          fileCount: field['fileCount'] as int? ?? 1,
          allowedExtensions:
              List<String>.from(field['allowedExtensions'] ?? []),
          onFilesSelected: (files) {
            setState(() {
              _fileData[label] = files;
            });
          },
        );
      case 'multiselect':
        return MultiSelectField(
          label: label,
          isRequired: isRequired,
          dropDownItemsList:
              List<String>.from(field['dropDownItemsList'] ?? []),
          onChanged: (values) {
            _controllers[label]!.text = values.join(', ');
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<List<Map<String, dynamic>>> _uploadFiles(
      String fieldLabel, List<PlatformFile> files) async {
    final List<Map<String, dynamic>> uploadedFiles = [];
    final formCubit = context.read<form_cubit.FormCubit>();

    for (var file in files) {
      if (file.bytes != null) {
        final String fileId = await formCubit.uploadFormFile(
          file.bytes!,
          file.name,
          file.extension == 'pdf' ? 'application/pdf' : 'application/msword',
        );

        uploadedFiles.add({
          'name': file.name,
          'type': file.extension ?? 'unknown',
          'size': file.size.toString(),
          'id': fileId,
        });
      }
    }

    return uploadedFiles;
  }

  Future<void> _submitForm() async {
    setState(() => _isSubmitting = true);

    try {
      // Validate required fields
      final fields = _formData['fields'] as List<dynamic>;
      for (var field in fields) {
        final label = field['label'] as String;
        final isRequired = field['isRequired'] as bool? ?? false;

        if (isRequired && (_controllers[label]?.text.isEmpty ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in $label')),
          );
          return;
        }
      }

      // Get current user
      final user = await Appwrite.account.get();

      // Prepare responses
      final Map<String, dynamic> responses = {};
      final List<Map<String, dynamic>> fileResponses = [];

      // Process each field
      for (var field in fields) {
        final label = field['label'] as String;
        final fieldType = field['fieldType'] as String;

        if (fieldType == 'file' && _fileData.containsKey(label)) {
          final uploadedFiles = await _uploadFiles(label, _fileData[label]!);
          fileResponses.addAll(uploadedFiles);
        } else {
          responses[label] = _controllers[label]?.text ?? '';
        }
      }

      // Create form response
      final response = FormResponseModel(
        id: ID.unique(),
        formId: widget.formId,
        userId: user.$id,
        responses: responses,
        fileResponses: fileResponses,
        submittedAt: DateTime.now(),
      );

      // Submit response using cubit
      await context.read<form_cubit.FormCubit>().submitFormResponse(response);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final fields = _formData['fields'] as List<dynamic>;

    return Scaffold(
      appBar: CustomAppBar(
        title: _formData['name'] ?? 'Form',
        actions: [
          IconButton(
            onPressed: _isSubmitting ? null : _submitForm,
            icon: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   _formData['title'] ?? 'Untitled Form',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 24),
            ...fields.map((field) {
              return Column(
                children: [
                  _buildFormField(field),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
