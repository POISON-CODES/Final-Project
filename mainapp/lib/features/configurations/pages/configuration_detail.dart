import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart' show GraduationStatus;
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/configurations/pages/create_configuration.dart';
import 'package:mainapp/features/master_data/cubit/master_data_cubit.dart';
import 'package:mainapp/models/models.dart';

class ConfigurationDetailPage extends StatefulWidget {
  final ConfigurationModel configuration;

  const ConfigurationDetailPage({
    super.key,
    required this.configuration,
  });

  static MaterialPageRoute route(ConfigurationModel configuration) =>
      MaterialPageRoute(
        builder: (context) =>
            ConfigurationDetailPage(configuration: configuration),
      );

  @override
  State<ConfigurationDetailPage> createState() =>
      _ConfigurationDetailPageState();
}

class _ConfigurationDetailPageState extends State<ConfigurationDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load all master data to show students in this batch
    context.read<MasterDataCubit>().getAllMasterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Configuration Details",
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                CreateConfiguration.routeWithData(widget.configuration),
              );
            },
            tooltip: "Edit Configuration",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(context),
            const SizedBox(height: 20),
            _buildStudentList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.configuration.course,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(widget.configuration.status),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.configuration.status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailItem("Department",
                widget.configuration.department.name.toUpperCase()),
            _buildDetailItem("Course Code", widget.configuration.courseCode),
            _buildDetailItem(
                "Specialization", widget.configuration.specialization),
            _buildDetailItem("Head of Institution", widget.configuration.hoi),
            _buildDetailItem(
                "Faculty Coordinator", widget.configuration.facultyCoordinator),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Student List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<MasterDataCubit, MasterDataState>(
                  builder: (context, state) {
                    if (state is MasterDataListLoaded) {
                      final students = state.masterDataList
                          .where(
                              (data) => data.batchId == widget.configuration.id)
                          .toList();
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${students.length} Students",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            BlocBuilder<MasterDataCubit, MasterDataState>(
              builder: (context, state) {
                if (state is MasterDataLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MasterDataListLoaded) {
                  final students = state.masterDataList
                      .where((data) => data.batchId == widget.configuration.id)
                      .toList();

                  if (students.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "No students in this batch yet",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            student.firstName.substring(0, 1).toUpperCase(),
                          ),
                        ),
                        title: Text(
                            "${student.firstName} ${student.middleName} ${student.lastName}"),
                        subtitle: Text(student.enrollmentNumber),
                        trailing: const Icon(Icons.info_outline),
                        onTap: () {
                          // Navigate to student detail or show more info
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Student details feature coming soon"),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is MasterDataError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Error loading students: ${state.message}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(GraduationStatus status) {
    switch (status) {
      case GraduationStatus.ug:
        return Colors.green;
      case GraduationStatus.pg:
        return Colors.blue;
      case GraduationStatus.phd:
        return Colors.purple;
    }
  }
}
