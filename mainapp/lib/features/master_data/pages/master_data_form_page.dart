import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/features/files/cubit/file_cubit.dart';
import 'package:mainapp/features/master_data/cubit/master_data_cubit.dart';
import 'package:mainapp/models/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/features/requests/cubit/request_cubit.dart';

class MasterDataFormPage extends StatefulWidget {
  const MasterDataFormPage({super.key});

  @override
  State<MasterDataFormPage> createState() => _MasterDataFormPageState();
}

class _MasterDataFormPageState extends State<MasterDataFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  late final TextEditingController _enrollmentNumberController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _collegeLocationController;
  late final TextEditingController _preferredLocationController;
  late final TextEditingController _graduationDegreeController;
  late final TextEditingController _graduationSpecializationController;
  late final TextEditingController _graduationYearOfPassingController;
  late final TextEditingController _graduationPercentageController;
  late final TextEditingController _mastersDegreeController;
  late final TextEditingController _mastersSpecializationController;
  late final TextEditingController _mastersYearOfPassingController;
  late final TextEditingController _mastersPercentageController;
  late final TextEditingController _experienceInMonthsController;
  late final TextEditingController _resumeLinkController;
  late final TextEditingController _technicalWorkLinkController;
  late final TextEditingController _linkedinProfileLinkController;
  late final TextEditingController _std10thBoardController;
  late final TextEditingController _std10thPercentageController;
  late final TextEditingController _std12thBoardController;
  late final TextEditingController _std12thPercentageController;
  late final TextEditingController _currentLocationController;
  late final TextEditingController _permanentLocationController;
  late final TextEditingController _std10thPassingYearController;
  late final TextEditingController _std12thPassingYearController;
  late final TextEditingController _alternatePhoneNumberController;
  late final TextEditingController _amityEmailController;
  late final TextEditingController _fathersNameController;
  late final TextEditingController _mothersNameController;
  late final TextEditingController _fathersPhoneNumberController;
  late final TextEditingController _mothersPhoneNumberController;
  late final TextEditingController _fathersEmailController;
  late final TextEditingController _mothersEmailController;
  late final TextEditingController _activeBackLogsController;
  late final TextEditingController _dateOfBirthController;

  String? _selectedBatchId;
  String? _selectedGender;
  bool _priorExperience = false;
  DateTime? _selectedDob;
  bool _graduationFieldsEnabled = true;
  bool _mastersFieldsEnabled = true;
  GraduationStatus? _selectedBatchStatus;
  List<PlatformFile> _selectedResumeFiles = [];
  String? _uploadedResumeId;
  String? _selectedDepartment;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _emailAddressController = TextEditingController();
    _enrollmentNumberController = TextEditingController();
    _collegeLocationController = TextEditingController();
    _preferredLocationController = TextEditingController();
    _graduationDegreeController = TextEditingController();
    _graduationSpecializationController = TextEditingController();
    _graduationYearOfPassingController = TextEditingController();
    _graduationPercentageController = TextEditingController();
    _mastersDegreeController = TextEditingController();
    _mastersSpecializationController = TextEditingController();
    _mastersYearOfPassingController = TextEditingController();
    _mastersPercentageController = TextEditingController();
    _experienceInMonthsController = TextEditingController();
    _resumeLinkController = TextEditingController();
    _technicalWorkLinkController = TextEditingController();
    _linkedinProfileLinkController = TextEditingController();
    _std10thBoardController = TextEditingController();
    _std10thPercentageController = TextEditingController();
    _std12thBoardController = TextEditingController();
    _std12thPercentageController = TextEditingController();
    _currentLocationController = TextEditingController();
    _permanentLocationController = TextEditingController();
    _std10thPassingYearController = TextEditingController();
    _std12thPassingYearController = TextEditingController();
    _alternatePhoneNumberController = TextEditingController();
    _amityEmailController = TextEditingController();
    _fathersNameController = TextEditingController();
    _mothersNameController = TextEditingController();
    _fathersPhoneNumberController = TextEditingController();
    _mothersPhoneNumberController = TextEditingController();
    _fathersEmailController = TextEditingController();
    _mothersEmailController = TextEditingController();
    _activeBackLogsController = TextEditingController();
    _dateOfBirthController = TextEditingController();

    // Load configurations
    context.read<ConfigurationCubit>().getAllConfigurations();

    // Pre-fill user details
    final AuthState authState = context.read<AuthCubit>().state;
    if (authState is AuthStudentAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
      context.read<MasterDataCubit>().getMasterDataById(authState.user.id);
    } else if (authState is AuthCoordinatorAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
      context.read<MasterDataCubit>().getMasterDataById(authState.user.id);
    } else if (authState is AuthAdminAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
      context.read<MasterDataCubit>().getMasterDataById(authState.user.id);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _enrollmentNumberController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();
    _collegeLocationController.dispose();
    _preferredLocationController.dispose();
    _graduationDegreeController.dispose();
    _graduationSpecializationController.dispose();
    _graduationYearOfPassingController.dispose();
    _graduationPercentageController.dispose();
    _mastersDegreeController.dispose();
    _mastersSpecializationController.dispose();
    _mastersYearOfPassingController.dispose();
    _mastersPercentageController.dispose();
    _experienceInMonthsController.dispose();
    _resumeLinkController.dispose();
    _technicalWorkLinkController.dispose();
    _linkedinProfileLinkController.dispose();
    _std10thBoardController.dispose();
    _std10thPercentageController.dispose();
    _std12thBoardController.dispose();
    _std12thPercentageController.dispose();
    _currentLocationController.dispose();
    _permanentLocationController.dispose();
    _std10thPassingYearController.dispose();
    _std12thPassingYearController.dispose();
    _alternatePhoneNumberController.dispose();
    _amityEmailController.dispose();
    _fathersNameController.dispose();
    _mothersNameController.dispose();
    _fathersPhoneNumberController.dispose();
    _mothersPhoneNumberController.dispose();
    _fathersEmailController.dispose();
    _mothersEmailController.dispose();
    _activeBackLogsController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _uploadResume() async {
    try {
      if (_selectedResumeFiles.isNotEmpty) {
        final file = _selectedResumeFiles.first;
        if (file.bytes != null) {
          final String fileId = await context.read<FileCubit>().uploadFile(
                file.bytes!,
                file.name,
                Buckets.defaultResumeBucket,
              );
          setState(() {
            _uploadedResumeId = fileId;
            _resumeLinkController.text = fileId;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading resume: $e")),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedBatchId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a batch')),
        );
        return;
      }

      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a gender')),
        );
        return;
      }

      // Show uploading dialog if resume is selected
      if (_selectedResumeFiles.isNotEmpty && _uploadedResumeId == null) {
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
                  Text("Uploading Resume..."),
                ],
              ),
            );
          },
        );

        // Upload resume and wait for completion
        try {
          await _uploadResume();
          Navigator.of(context).pop();
        } catch (e) {
          // Close the uploading dialog
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error uploading resume: $e")),
          );
          return;
        }
      }

      // Get current user data from auth state
      final authState = context.read<AuthCubit>().state;
      Map<String, dynamic> userData = {};
      if (authState is AuthStudentAuthenticated) {
        userData = {
          'id': authState.user.id,
          'name': authState.user.name,
          'email': authState.user.email,
          'phoneNumber': authState.user.phoneNumber,
          'role': authState.user.role.toString(),
        };
      } else if (authState is AuthCoordinatorAuthenticated) {
        userData = {
          'id': authState.user.id,
          'name': authState.user.name,
          'email': authState.user.email,
          'phoneNumber': authState.user.phoneNumber,
          'role': authState.user.role.toString(),
        };
      } else if (authState is AuthAdminAuthenticated) {
        userData = {
          'id': authState.user.id,
          'name': authState.user.name,
          'email': authState.user.email,
          'phoneNumber': authState.user.phoneNumber,
          'role': authState.user.role.toString(),
        };
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You must be logged in to submit the form')),
        );
        return;
      }

      // Submit master data
      print(_selectedDob);
      final masterData = MasterDataModel(
        id: userData['id'],
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text,
        enrollmentNumber: _enrollmentNumberController.text,
        batchId: _selectedBatchId!,
        gender: _selectedGender!,
        phoneNumber: _phoneNumberController.text,
        emailAddress: _emailAddressController.text,
        collegeLocation: _collegeLocationController.text,
        preferredLocation: _preferredLocationController.text,
        graduationDegree: _graduationDegreeController.text,
        graduationSpecialization: _graduationSpecializationController.text,
        graduationYearOfPassing: _graduationYearOfPassingController.text,
        graduationPercentage: _graduationPercentageController.text,
        mastersDegree: _mastersDegreeController.text,
        mastersSpecialization: _mastersSpecializationController.text,
        mastersYearOfPassing: _mastersYearOfPassingController.text,
        mastersPercentage: _mastersPercentageController.text,
        priorExperience: _priorExperience,
        experienceInMonths: _experienceInMonthsController.text,
        resumeLink: _uploadedResumeId ?? _resumeLinkController.text,
        technicalWorkLink: _technicalWorkLinkController.text,
        department: _selectedDepartment!,
        dob: _selectedDob!,
        linkedinProfileLink: _linkedinProfileLinkController.text,
        std10thBoard: _std10thBoardController.text,
        std10thPercentage: _std10thPercentageController.text,
        std12thBoard: _std12thBoardController.text,
        std12thPercentage: _std12thPercentageController.text,
        currentLocation: _currentLocationController.text,
        permanentLocation: _permanentLocationController.text,
        std10thPassingYear: _std10thPassingYearController.text,
        std12thPassingYear: _std12thPassingYearController.text,
        alternatePhoneNumber: _alternatePhoneNumberController.text,
        amityEmail: _amityEmailController.text,
        fathersName: _fathersNameController.text,
        mothersName: _mothersNameController.text,
        fathersPhoneNumber: _fathersPhoneNumberController.text,
        mothersPhoneNumber: _mothersPhoneNumberController.text,
        fathersEmail: _fathersEmailController.text,
        mothersEmail: _mothersEmailController.text,
        activeBackLogs: _activeBackLogsController.text,
      );

      // Submit both master data and request
      await context
          .read<MasterDataCubit>()
          .submitMasterData(masterData, userData['id']);

      final request = RequestModel(
        type: RequestType.masterData,
        status: RequestStatus.pending,
      );
      context.read<RequestCubit>().createRequest(request, userData['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterDataCubit, MasterDataState>(
      listener: (context, state) {
        if (state is MasterDataError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is MasterDataLoaded) {
          _prefillForm(state.masterData);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Master Data Form'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _submitForm,
            icon: const Icon(Icons.check),
            label: const Text('Submit'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Personal Information Section
                  _buildSectionCard(
                    title: 'Personal Information',
                    icon: Icons.person,
                    children: [
                      _buildPersonalInfoFields(),
                      const SizedBox(height: 16),
                      _buildGenderField(),
                      const SizedBox(height: 16),
                      _buildDateField(
                        controller: _dateOfBirthController,
                        label: 'Date of Birth',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _phoneNumberController,
                        label: 'Phone Number',
                        textInputType: TextInputType.phone,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _emailAddressController,
                        label: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _alternatePhoneNumberController,
                        label: 'Alternate Phone Number',
                        textInputType: TextInputType.phone,
                      ),
                      _buildFormField(
                        controller: _amityEmailController,
                        label: 'Amity Email',
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return null;
                          if (!value!.endsWith('s.amity.edu')) {
                            return 'Amity email must end with s.amity.edu';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                  // Academic Information Section
                  _buildSectionCard(
                    title: 'Academic Information',
                    icon: Icons.school,
                    children: [
                      _buildFormField(
                        controller: _std10thBoardController,
                        label: '10th Board',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _std10thPercentageController,
                        label: '10th Percentage',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _std10thPassingYearController,
                        label: '10th Passing Year',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _std12thBoardController,
                        label: '12th Board',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _std12thPercentageController,
                        label: '12th Percentage',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _std12thPassingYearController,
                        label: '12th Passing Year',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ],
                  ),

                  // Higher Education Information Section
                  _buildSectionCard(
                    title: 'Higher Education Information',
                    icon: Icons.workspace_premium,
                    children: [
                      BlocBuilder<ConfigurationCubit, ConfigurationState>(
                        builder: (context, state) {
                          if (state is ConfigurationLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ConfigurationsLoaded) {
                            if (state.configurations.isEmpty) {
                              return const Text('No batches available');
                            }

                            List<String> batchOptions = [];
                            Map<String, String> batchIdToDisplayMap = {};

                            for (var config in state.configurations) {
                              String displayText =
                                  "${config.department.name.toUpperCase()} - ${config.course} - ${config.specialization}";
                              batchOptions.add(displayText);
                              batchIdToDisplayMap[displayText] = config.id;
                            }

                            return _buildDropDownField(
                              controller: TextEditingController(),
                              label: 'Select your Batch',
                              items: batchOptions,
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  final selectedConfig =
                                      state.configurations.firstWhere(
                                    (config) =>
                                        batchIdToDisplayMap[newValue] ==
                                        config.id,
                                  );
                                  setState(() {
                                    _selectedBatchId = selectedConfig.id;
                                    _selectedDepartment =
                                        selectedConfig.department.name;

                                    // Check if the batch is UG or PG based on status
                                    if (selectedConfig.status ==
                                        GraduationStatus.ug) {
                                      // UG Batch
                                      _graduationDegreeController.text =
                                          selectedConfig.course;
                                      _graduationSpecializationController.text =
                                          selectedConfig.specialization;
                                      _graduationFieldsEnabled = false;

                                      // Set masters fields to N/A and disable them
                                      _mastersDegreeController.text = 'N/A';
                                      _mastersSpecializationController.text =
                                          'N/A';
                                      _mastersYearOfPassingController.text =
                                          'N/A';
                                      _mastersPercentageController.text = 'N/A';
                                      _mastersFieldsEnabled = false;
                                      _selectedBatchStatus =
                                          GraduationStatus.ug;
                                    } else if (selectedConfig.status ==
                                        GraduationStatus.pg) {
                                      // PG Batch
                                      _mastersDegreeController.text =
                                          selectedConfig.course;
                                      _mastersSpecializationController.text =
                                          selectedConfig.specialization;
                                      _mastersYearOfPassingController.text =
                                          ''; // Empty the year of passing
                                      _mastersPercentageController.text =
                                          ''; // Empty the percentage

                                      // Enable only year of passing and percentage fields
                                      _mastersFieldsEnabled = true;
                                      _selectedBatchStatus =
                                          GraduationStatus.pg;

                                      // Empty and enable graduation fields
                                      _graduationDegreeController.text = '';
                                      _graduationSpecializationController.text =
                                          '';
                                      _graduationFieldsEnabled = true;
                                    }
                                  });
                                }
                              },
                            );
                          }
                          return const Text('Failed to load batches');
                        },
                      ),
                      _buildFormField(
                        controller: _graduationDegreeController,
                        label: 'Graduation Degree',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                        enabled: _graduationFieldsEnabled,
                      ),
                      _buildFormField(
                        controller: _graduationSpecializationController,
                        label: 'Graduation Specialization',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                        enabled: _graduationFieldsEnabled,
                      ),
                      _buildFormField(
                        controller: _graduationYearOfPassingController,
                        label: 'Graduation Year of Passing',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _graduationPercentageController,
                        label: 'Graduation Percentage',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _activeBackLogsController,
                        label: 'Active Backlogs',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _mastersDegreeController,
                        label: 'Masters Degree',
                        enabled: _mastersFieldsEnabled &&
                            _selectedBatchStatus != GraduationStatus.pg,
                      ),
                      _buildFormField(
                        controller: _mastersSpecializationController,
                        label: 'Masters Specialization',
                        enabled: _mastersFieldsEnabled &&
                            _selectedBatchStatus != GraduationStatus.pg,
                      ),
                      _buildFormField(
                        controller: _mastersYearOfPassingController,
                        label: 'Masters Year of Passing',
                        textInputType: TextInputType.number,
                        enabled: _mastersFieldsEnabled,
                      ),
                      _buildFormField(
                        controller: _mastersPercentageController,
                        label: 'Masters Percentage',
                        textInputType: TextInputType.number,
                        enabled: _mastersFieldsEnabled,
                      ),
                    ],
                  ),

                  // Professional Information Section
                  _buildSectionCard(
                    title: 'Professional Information',
                    icon: Icons.work,
                    children: [
                      _buildPriorExperienceField(),
                      FileUploadField(
                        label: 'Resume',
                        fileCount: 1,
                        allowedExtensions: [
                          'pdf',
                        ],
                        onFilesSelected: (files) {
                          setState(() {
                            _selectedResumeFiles = files;
                          });
                        },
                      ),
                      _buildFormField(
                        controller: _technicalWorkLinkController,
                        label: 'Technical Work Link',
                      ),
                      _buildFormField(
                        controller: _linkedinProfileLinkController,
                        label: 'LinkedIn Profile Link',
                      ),
                    ],
                  ),

                  // Location Information Section
                  _buildSectionCard(
                    title: 'Location Information',
                    icon: Icons.location_on,
                    children: [
                      _buildFormField(
                        controller: _collegeLocationController,
                        label: 'College Location',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _preferredLocationController,
                        label: 'Preferred Location',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _currentLocationController,
                        label: 'Current Location',
                      ),
                      _buildFormField(
                        controller: _permanentLocationController,
                        label: 'Permanent Location',
                      ),
                    ],
                  ),

                  // Parent Information Section
                  _buildSectionCard(
                    title: 'Parent Information',
                    icon: Icons.family_restroom,
                    children: [
                      _buildFormField(
                        controller: _fathersNameController,
                        label: "Father's Name",
                      ),
                      _buildFormField(
                        controller: _mothersNameController,
                        label: "Mother's Name",
                      ),
                      _buildFormField(
                        controller: _fathersPhoneNumberController,
                        label: "Father's Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      _buildFormField(
                        controller: _mothersPhoneNumberController,
                        label: "Mother's Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      _buildFormField(
                        controller: _fathersEmailController,
                        label: "Father's Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                      _buildFormField(
                        controller: _mothersEmailController,
                        label: "Mother's Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? textInputType,
    String? Function(String?)? validator,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomFormField(
        controller: controller,
        label: label,
        textInputType: textInputType,
        validator: validator,
        enabled: enabled,
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildDropDownField({
    required TextEditingController controller,
    required String label,
    required List<String> items,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomDropDown(
        label: label,
        dropDownItemsList: items,
        onChanged: onChanged ?? (value) => controller.text = value ?? '',
        initialValue: controller.text.isEmpty ? null : controller.text,
        isRequired: validator != null,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomFormField(
        controller: controller,
        label: label,
        enabled: enabled,
        validator: validator,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: enabled
              ? () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDob ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDob = picked;
                      controller.text =
                          '${picked.day}/${picked.month}/${picked.year}';
                    });
                  }
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildPriorExperienceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prior Experience',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: _priorExperience,
              onChanged: (value) {
                setState(() {
                  _priorExperience = value!;
                });
              },
            ),
            const Text('Yes'),
            const SizedBox(width: 16),
            Radio<bool>(
              value: false,
              groupValue: _priorExperience,
              onChanged: (value) {
                setState(() {
                  _priorExperience = value!;
                });
              },
            ),
            const Text('No'),
          ],
        ),
        if (_priorExperience) ...[
          const SizedBox(height: 16),
          CustomFormField(
            controller: _experienceInMonthsController,
            label: 'Experience in Months',
            textInputType: TextInputType.number,
            validator: (value) {
              if (_priorExperience && (value == null || value.isEmpty)) {
                return 'Please enter your experience in months';
              }
              return null;
            },
          ),
        ],
      ],
    );
  }

  Widget _buildGenderField() {
    return CustomDropDown(
      label: 'Gender',
      dropDownItemsList: _genderOptions,
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      initialValue: _selectedGender,
      isRequired: true,
    );
  }

  Widget _buildPersonalInfoFields() {
    return Column(
      children: [
        CustomFormField(
          controller: _firstNameController,
          label: 'First Name',
          isRequired: true,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: _middleNameController,
          label: 'Middle Name',
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: _lastNameController,
          label: 'Last Name',
          isRequired: true,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: _enrollmentNumberController,
          label: 'Enrollment Number',
          isRequired: true,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Required';
            }
            // Add validation for enrollment number format if needed
            return null;
          },
        ),
      ],
    );
  }

  void _prefillForm(MasterDataModel masterData) {
    // Personal Information
    _firstNameController.text = masterData.firstName;
    _middleNameController.text = masterData.middleName;
    _lastNameController.text = masterData.lastName;
    _enrollmentNumberController.text = masterData.enrollmentNumber;
    _phoneNumberController.text = masterData.phoneNumber;
    _emailAddressController.text = masterData.emailAddress;
    _alternatePhoneNumberController.text = masterData.alternatePhoneNumber;
    _amityEmailController.text = masterData.amityEmail;
    _selectedGender = masterData.gender;
    _selectedDob = masterData.dob;
    _dateOfBirthController.text =
        '${masterData.dob.day}/${masterData.dob.month}/${masterData.dob.year}';

    // Academic Information
    _std10thBoardController.text = masterData.std10thBoard;
    _std10thPercentageController.text = masterData.std10thPercentage;
    _std10thPassingYearController.text = masterData.std10thPassingYear;
    _std12thBoardController.text = masterData.std12thBoard;
    _std12thPercentageController.text = masterData.std12thPercentage;
    _std12thPassingYearController.text = masterData.std12thPassingYear;
    _activeBackLogsController.text = masterData.activeBackLogs;

    // Higher Education Information
    _selectedBatchId = masterData.batchId;
    _selectedDepartment = masterData.department;
    _graduationDegreeController.text = masterData.graduationDegree;
    _graduationSpecializationController.text =
        masterData.graduationSpecialization;
    _graduationYearOfPassingController.text =
        masterData.graduationYearOfPassing;
    _graduationPercentageController.text = masterData.graduationPercentage;
    _mastersDegreeController.text = masterData.mastersDegree;
    _mastersSpecializationController.text = masterData.mastersSpecialization;
    _mastersYearOfPassingController.text = masterData.mastersYearOfPassing;
    _mastersPercentageController.text = masterData.mastersPercentage;

    // Professional Information
    _priorExperience = masterData.priorExperience;
    _experienceInMonthsController.text = masterData.experienceInMonths;
    _resumeLinkController.text = masterData.resumeLink;
    _technicalWorkLinkController.text = masterData.technicalWorkLink;
    _linkedinProfileLinkController.text = masterData.linkedinProfileLink;

    // Location Information
    _collegeLocationController.text = masterData.collegeLocation;
    _preferredLocationController.text = masterData.preferredLocation;
    _currentLocationController.text = masterData.currentLocation;
    _permanentLocationController.text = masterData.permanentLocation;

    // Parent Information
    _fathersNameController.text = masterData.fathersName;
    _mothersNameController.text = masterData.mothersName;
    _fathersPhoneNumberController.text = masterData.fathersPhoneNumber;
    _mothersPhoneNumberController.text = masterData.mothersPhoneNumber;
    _fathersEmailController.text = masterData.fathersEmail;
    _mothersEmailController.text = masterData.mothersEmail;

    // Update UI state
    setState(() {
      // Enable/disable fields based on batch status
      final configState = context.read<ConfigurationCubit>().state;
      if (configState is ConfigurationsLoaded) {
        final selectedConfig = configState.configurations.firstWhere(
          (config) => config.id == masterData.batchId,
          orElse: () => throw Exception('Configuration not found'),
        );

        if (selectedConfig.status == GraduationStatus.ug) {
          _graduationFieldsEnabled = false;
          _mastersFieldsEnabled = false;
          _selectedBatchStatus = GraduationStatus.ug;
        } else if (selectedConfig.status == GraduationStatus.pg) {
          _graduationFieldsEnabled = true;
          _mastersFieldsEnabled = true;
          _selectedBatchStatus = GraduationStatus.pg;
        }
      }
    });
  }
}
