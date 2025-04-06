import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/features/master_data/cubit/master_data_cubit.dart';
import 'package:mainapp/models/models.dart';
import 'package:mainapp/constants/constants.dart' show GraduationStatus;

class MasterDataFormPage extends StatefulWidget {
  const MasterDataFormPage({super.key});

  @override
  State<MasterDataFormPage> createState() => _MasterDataFormPageState();
}

class _MasterDataFormPageState extends State<MasterDataFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _lastNameController;
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
  late final TextEditingController _githubProfileLinkController;
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

  String _selectedGender = 'Male';
  String _selectedDepartment = 'Computer Science';
  String? _selectedBatchId;
  ConfigurationModel? _selectedBatch;
  String? _priorExperience;
  DateTime? _selectedDob;
  bool _mastersFieldsEnabled = true;
  bool _graduationFieldsEnabled = true;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _enrollmentNumberController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailAddressController = TextEditingController();
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
    _githubProfileLinkController = TextEditingController();
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
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthStudentAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
    } else if (authState is AuthCoordinatorAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
    } else if (authState is AuthAdminAuthenticated) {
      _phoneNumberController.text = authState.user.phoneNumber;
      _emailAddressController.text = authState.user.email;
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
    _githubProfileLinkController.dispose();
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedBatchId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a batch')),
        );
        return;
      }

      final masterData = MasterDataModel(
        id: '',
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text,
        enrollmentNumber: _enrollmentNumberController.text,
        batchId: _selectedBatchId!,
        gender: _selectedGender,
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
        priorExperience: _priorExperience!,
        experienceInMonths: _experienceInMonthsController.text,
        resumeLink: _resumeLinkController.text,
        technicalWorkLink: _technicalWorkLinkController.text,
        department: _selectedDepartment,
        dob: _selectedDob!,
        linkedinProfileLink: _linkedinProfileLinkController.text,
        githubProfileLink: _githubProfileLinkController.text,
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

      context.read<MasterDataCubit>().submitMasterData(masterData);
    }
  }

  void _handleBatchSelection(
      String? newValue,
      Map<String, String> batchIdToDisplayMap,
      List<ConfigurationModel> configurations) {
    if (newValue != null) {
      setState(() {
        _selectedBatchId = batchIdToDisplayMap[newValue];
        _selectedBatch = configurations
            .firstWhere((config) => config.id == _selectedBatchId);

        // Reset all fields to their default state
        _mastersFieldsEnabled = true;
        _graduationFieldsEnabled = true;

        // Handle UG/PG logic
        if (_selectedBatch!.status == GraduationStatus.ug) {
          // For UG, set graduation fields and disable masters fields
          _graduationDegreeController.text = _selectedBatch!.course;
          _graduationSpecializationController.text =
              _selectedBatch!.specialization;
          _mastersDegreeController.text = 'N/A';
          _mastersSpecializationController.text = 'N/A';
          _mastersYearOfPassingController.text = 'N/A';
          _mastersPercentageController.text = 'N/A';
          // Disable masters fields and graduation fields
          _mastersFieldsEnabled = false;
          _graduationFieldsEnabled = false;
        } else if (_selectedBatch!.status == GraduationStatus.pg) {
          // For PG, set masters fields and leave graduation fields editable
          _mastersDegreeController.text = _selectedBatch!.course;
          _mastersSpecializationController.text =
              _selectedBatch!.specialization;
          // Disable masters fields and enable graduation fields
          _mastersFieldsEnabled = false;
          _graduationFieldsEnabled = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<MasterDataCubit, MasterDataState>(
        listener: (context, state) {
          if (state is MasterDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          } else if (state is MasterDataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Master data submitted successfully'),
                backgroundColor: Theme.of(context).colorScheme.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is MasterDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
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
                      _buildFormField(
                        controller: _firstNameController,
                        label: 'First Name',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _middleNameController,
                        label: 'Middle Name',
                      ),
                      _buildFormField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      _buildFormField(
                        controller: _enrollmentNumberController,
                        label: 'Enrollment Number',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
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

                            return _buildDropDown(
                              label: 'Batch',
                              dropDownItemsList: batchOptions,
                              onChanged: (String? newValue) {
                                _handleBatchSelection(newValue,
                                    batchIdToDisplayMap, state.configurations);
                              },
                              initialValue: _selectedBatchId != null
                                  ? batchOptions.firstWhere(
                                      (option) =>
                                          batchIdToDisplayMap[option] ==
                                          _selectedBatchId,
                                      orElse: () => batchOptions.first)
                                  : null,
                              isRequired: true,
                            );
                          }
                          return const Text('Failed to load batches');
                        },
                      ),
                      _buildDropDown(
                        label: 'Gender',
                        dropDownItemsList: ['Male', 'Female', 'Other'],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          }
                        },
                        initialValue: _selectedGender,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDob ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDob = picked;
                              _dateOfBirthController.text =
                                  '${picked.day}/${picked.month}/${picked.year}';
                            });
                          }
                        },
                        child: _buildFormField(
                          controller: _dateOfBirthController,
                          label: 'Date of Birth',
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Required' : null,
                          enabled: false,
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
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
                        controller: _mastersDegreeController,
                        label: 'Masters Degree',
                        enabled: _mastersFieldsEnabled,
                      ),
                      _buildFormField(
                        controller: _mastersSpecializationController,
                        label: 'Masters Specialization',
                        enabled: _mastersFieldsEnabled,
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
                      _buildFormField(
                        controller: _activeBackLogsController,
                        label: 'Active Backlogs',
                        textInputType: TextInputType.number,
                      ),
                    ],
                  ),

                  // Professional Information Section
                  _buildSectionCard(
                    title: 'Professional Information',
                    icon: Icons.work,
                    children: [
                      _buildDropDown(
                        label: 'Prior Experience',
                        dropDownItemsList: ['Yes', 'No'],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _priorExperience = newValue;
                            });
                          }
                        },
                        initialValue: _priorExperience,
                      ),
                      if (_priorExperience == 'Yes')
                        _buildFormField(
                          controller: _experienceInMonthsController,
                          label: 'Experience in Months',
                          textInputType: TextInputType.number,
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Required' : null,
                        ),
                      _buildFormField(
                        controller: _resumeLinkController,
                        label: 'Resume Link',
                      ),
                      _buildFormField(
                        controller: _technicalWorkLinkController,
                        label: 'Technical Work Link',
                      ),
                      _buildFormField(
                        controller: _linkedinProfileLinkController,
                        label: 'LinkedIn Profile Link',
                      ),
                      _buildFormField(
                        controller: _githubProfileLinkController,
                        label: 'GitHub Profile Link',
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
          );
        },
      ),
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
              color: Theme.of(context).primaryColor.withOpacity(0.05),
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.8),
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            validator: validator,
            enabled: enabled,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              filled: true,
              fillColor: enabled
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).disabledColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDown({
    required String label,
    required List<String> dropDownItemsList,
    required void Function(String?) onChanged,
    String? initialValue,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.8),
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            child: DropdownButtonFormField<String>(
              value: initialValue,
              items: dropDownItemsList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: InputBorder.none,
                hintText: 'Select $label',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
