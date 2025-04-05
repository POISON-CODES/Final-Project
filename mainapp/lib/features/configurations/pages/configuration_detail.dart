import 'package:flutter/material.dart';
import 'package:mainapp/constants/constants.dart' show GraduationStatus;
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/configurations/pages/create_configuration.dart';
import 'package:mainapp/models/models.dart';

class ConfigurationDetailPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Configuration Details",
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                CreateConfiguration.routeWithData(configuration),
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
                  configuration.course,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(configuration.status),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    configuration.status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailItem(
                "Department", configuration.department.name.toUpperCase()),
            _buildDetailItem("Course Code", configuration.courseCode),
            _buildDetailItem("Specialization", configuration.specialization),
            _buildDetailItem("Head of Institution", configuration.hoi),
            _buildDetailItem(
                "Faculty Coordinator", configuration.facultyCoordinator),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${configuration.studentList.length} Students",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (configuration.studentList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "No students in this configuration yet",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: configuration.studentList.length,
                itemBuilder: (context, index) {
                  final student = configuration.studentList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        student != null
                            ? student.substring(0, 1).toUpperCase()
                            : "?",
                      ),
                    ),
                    title: Text(student ?? "Unknown Student"),
                    trailing: const Icon(Icons.info_outline),
                    onTap: () {
                      // Navigate to student detail or show more info
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Student details feature coming soon"),
                        ),
                      );
                    },
                  );
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
