import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';

class CreateConfiguration extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => CreateConfiguration());
  const CreateConfiguration({super.key});

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
  void dispose() {
    _courseController.dispose();
    _specializationController.dispose();
    _courseCodeController.dispose();
    _hoiController.dispose();
    _facultyCoordinatorController.dispose();
    super.dispose();
  }

  void _createConfiguration() {
    if (formKey.currentState!.validate()) {
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
            content: Text(
                'Configuration created successfully : ${state.model.toString()}'),
          ));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ConfigurationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Add Configuration',
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
                        itemsList: _departments,
                        onChanged: (val) {
                          setState(() {
                            _department = val;
                          });
                        },
                        label: 'Select a department',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _courseController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        labelText: 'Course',
                        validator: null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _specializationController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        labelText: 'Specialization',
                        validator: null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _courseCodeController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        labelText: 'Course Code',
                        validator: null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _hoiController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        labelText: 'HOI',
                        validator: null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: _facultyCoordinatorController,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        labelText: 'Faculty Co-ordinator',
                        validator: null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDropDown(
                        itemsList: _graduationStatuses,
                        onChanged: (val) {
                          setState(() {
                            _graduationStatus = val;
                          });
                        },
                        label: 'Select a Graduation Status',
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
                  ),
                )),
          ),
        );
      },
    );
  }
}
