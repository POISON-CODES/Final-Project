import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart' show Priority;
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/companies/cubit/company_cubit.dart';
import 'package:mainapp/features/updates/cubit/update_cubit.dart';

class CreateUpdatePage extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const CreateUpdatePage(),
      );

  const CreateUpdatePage({super.key});

  @override
  State<CreateUpdatePage> createState() => _CreateUpdatePageState();
}

class _CreateUpdatePageState extends State<CreateUpdatePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController updateController = TextEditingController();
  Priority selectedPriority = Priority.medium;
  String? selectedCompanyId;

  @override
  void initState() {
    super.initState();
    context.read<CompanyCubit>().getAllCompanies();
  }

  @override
  void dispose() {
    updateController.dispose();
    super.dispose();
  }

  void _createUpdate() {
    if (formKey.currentState!.validate()) {
      context.read<UpdateCubit>().createUpdate(
            companyId: selectedCompanyId ?? 'generic',
            update: updateController.text.trim(),
            priority: selectedPriority,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Create Update",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: _createUpdate,
              icon: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UpdateCubit, UpdateState>(
        listener: (context, state) {
          if (state is UpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is UpdateCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Update created successfully!")),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is UpdateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CompanyCubit, CompanyState>(
                    builder: (context, state) {
                      if (state is CompanyLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CompanyError) {
                        return Center(child: Text(state.error));
                      } else if (state is CompaniesLoaded) {
                        final companies = state.companies;
                        return DropdownButtonFormField<String>(
                          value: selectedCompanyId,
                          decoration: const InputDecoration(
                            labelText: 'Select Company',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            ...companies.map((company) {
                              return DropdownMenuItem(
                                value: company.id,
                                child: Text(company.name),
                              );
                            }),
                            const DropdownMenuItem(
                              value: 'generic',
                              child: Text('Generic Update'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedCompanyId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a company or generic update';
                            }
                            return null;
                          },
                        );
                      }
                      return const Center(child: Text('Loading companies...'));
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: updateController,
                    decoration: const InputDecoration(
                      labelText: 'Update',
                      hintText: 'Enter the update details',
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an update';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Priority',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Priority>(
                    value: selectedPriority,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: Priority.values.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedPriority = value;
                        });
                      }
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
