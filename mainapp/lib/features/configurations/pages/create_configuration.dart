import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/models/models.dart';

class CreateConfiguration extends StatefulWidget {
  final ConfigurationModel? existingConfiguration;
  final bool isEditing;

  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const CreateConfiguration());

  static MaterialPageRoute routeWithData(ConfigurationModel configuration) =>
      MaterialPageRoute(
        builder: (context) => CreateConfiguration(
          existingConfiguration: configuration,
          isEditing: true,
        ),
      );

  const CreateConfiguration({
    super.key,
    this.existingConfiguration,
    this.isEditing = false,
  });

  @override
  State<CreateConfiguration> createState() => _CreateConfigurationState();
}

class _CreateConfigurationState extends State<CreateConfiguration> {
  final formKey = GlobalKey<FormState>();
  String? _department;
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _hoiController = TextEditingController();
  final TextEditingController _facultyCoordinatorController =
      TextEditingController();
  String? _graduationStatus;

  @override
  void initState() {
    super.initState();

    // If we're editing, populate the form with existing data
    if (widget.isEditing && widget.existingConfiguration != null) {
      _populateForm();
    }
  }

  void _populateForm() {
    final config = widget.existingConfiguration!;
    _department = config.department.name.toUpperCase();
    _courseController.text = config.course;
    _specializationController.text = config.specialization;
    _courseCodeController.text = config.courseCode;
    _hoiController.text = config.hoi;
    _facultyCoordinatorController.text = config.facultyCoordinator;
    _graduationStatus = config.status.name.toUpperCase();
  }

  @override
  void dispose() {
    _courseController.dispose();
    _specializationController.dispose();
    _courseCodeController.dispose();
    _hoiController.dispose();
    _facultyCoordinatorController.dispose();
    super.dispose();
  }

  void _saveConfiguration() {
    if (formKey.currentState!.validate()) {
      if (widget.isEditing) {
        // Call update configuration method (to be added in the cubit)
        context.read<ConfigurationCubit>().updateConfiguration(
              id: widget.existingConfiguration!.id,
              department: _department!,
              course: _courseController.text.trim(),
              specialization: _specializationController.text.trim(),
              courseCode: _courseCodeController.text.trim(),
              hoi: _hoiController.text.trim(),
              facultyCoordinator: _facultyCoordinatorController.text.trim(),
              graduateStatus: _graduationStatus!,
            );
      } else {
        context.read<ConfigurationCubit>().createConfiguration(
              department: _department!,
              course: _courseController.text.trim(),
              specialization: _specializationController.text.trim(),
              courseCode: _courseCodeController.text.trim(),
              hoi: _hoiController.text.trim(),
              facultyCoordinator: _facultyCoordinatorController.text.trim(),
              graduateStatus: _graduationStatus!,
            );
      }
    }
  }

  final List<String> _departments =
      Department.values.map((val) => val.name.toUpperCase()).toList();

  final List<String> _graduationStatuses =
      GraduationStatus.values.map((val) => val.name.toUpperCase()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigurationCubit, ConfigurationState>(
      listener: (context, state) {
        if (state is ConfigurationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        } else if (state is ConfigurationCreated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Configuration created successfully!'),
          ));
          Navigator.pop(context);
        } else if (state is ConfigurationEdit) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Configuration updated successfully!'),
          ));
          Navigator.pop(context);
          Navigator.pop(context); // Pop twice to go back to list view
        }
      },
      builder: (context, state) {
        if (state is ConfigurationLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: CustomAppBar(
            title:
                widget.isEditing ? 'Edit Configuration' : 'Add Configuration',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDropDown(
                        dropDownItemsList: _departments,
                        onChanged: (val) {
                          setState(() {
                            _department = val;
                          });
                        },
                        label: 'Select a department',
                        initialValue: _department,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _courseController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        label: 'Course',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a course name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _specializationController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        label: 'Specialization',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a specialization';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _courseCodeController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        label: 'Course Code',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a course code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _hoiController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        label: 'HOI',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter HOI name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _facultyCoordinatorController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        label: 'Faculty Co-ordinator',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter faculty coordinator name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDropDown(
                        dropDownItemsList: _graduationStatuses,
                        onChanged: (val) {
                          setState(() {
                            _graduationStatus = val;
                          });
                        },
                        label: 'Select a Graduation Status',
                        initialValue: _graduationStatus,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        onPressed: _saveConfiguration,
                        child: Text(
                          widget.isEditing ? 'Update' : 'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (widget.isEditing)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Discard Changes'),
                                  content: const Text(
                                      'Are you sure you want to discard the changes?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Discard',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            label: const Text('Cancel Editing',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
