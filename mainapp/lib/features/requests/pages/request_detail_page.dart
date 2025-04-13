import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/master_data/cubit/master_data_cubit.dart';
import 'package:mainapp/features/requests/cubit/request_cubit.dart';
import 'package:mainapp/models/models.dart';
import 'package:mainapp/constants/constants.dart';

class RequestDetailPage extends StatelessWidget {
  final RequestModel request;

  const RequestDetailPage({
    super.key,
    required this.request,
  });

  static MaterialPageRoute route(RequestModel request) => MaterialPageRoute(
      builder: (context) => RequestDetailPage(request: request));

  @override
  Widget build(BuildContext context) {
    // Load master data if this is a master data request
    if (request.type == RequestType.masterData) {
      context.read<MasterDataCubit>().getMasterDataById(request.id!);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Request Details',
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthAdminAuthenticated ||
                  state is AuthCoordinatorAuthenticated) {
                return IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showActionMenu(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 120, // Increased bottom padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(context),
                const SizedBox(height: 20), // Increased spacing
                _buildDetailsCard(context),
                const SizedBox(height: 20), // Increased spacing
                if (request.type == RequestType.masterData)
                  BlocBuilder<MasterDataCubit, MasterDataState>(
                    builder: (context, state) {
                      if (state is MasterDataLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MasterDataError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<MasterDataCubit>()
                                    .getMasterDataById(request.id!),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is MasterDataLoaded) {
                        return _buildMasterDataCard(context, state.masterData);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
              ],
            ),
          ),
          // Fixed buttons at the bottom
          if (request.status == RequestStatus.pending)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 20), // Increased top margin
                padding: const EdgeInsets.fromLTRB(
                    16, 16, 16, 20), // Adjusted padding
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8, // Increased blur radius
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _approveRequest(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Added border radius
                          ),
                        ),
                        child: const Text('Accept'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _rejectRequest(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Added border radius
                          ),
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      elevation: 2, // Added elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Added border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12), // Increased spacing
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, // Increased padding
                vertical: 8, // Increased padding
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(request.status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                request.status.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Increased font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      elevation: 2, // Added elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Added border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Type', request.type.displayName),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Created',
                request.createdAt?.toLocal().toString().split('.')[0] ?? 'N/A'),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Last Updated',
                request.updatedAt?.toLocal().toString().split('.')[0] ?? 'N/A'),
            if (request.approvedBy != null) ...[
              const Divider(height: 24), // Added divider
              _buildDetailRow('Approved By', request.approvedBy!),
            ],
            if (request.rejectedBy != null) ...[
              const Divider(height: 24), // Added divider
              _buildDetailRow('Rejected By', request.rejectedBy!),
            ],
            if (request.rejectionReason != null) ...[
              const Divider(height: 24), // Added divider
              _buildDetailRow('Rejection Reason', request.rejectionReason!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMasterDataCard(
      BuildContext context, MasterDataModel masterData) {
    return Card(
      elevation: 2, // Added elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Added border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Master Data',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Personal Information
            _buildSectionTitle(context, 'Personal Information'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Name',
                '${masterData.firstName} ${masterData.middleName} ${masterData.lastName}'),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Enrollment Number', masterData.enrollmentNumber),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Gender', masterData.gender),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Phone Number', masterData.phoneNumber),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Email', masterData.emailAddress),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Date of Birth',
                masterData.dob.toLocal().toString().split(' ')[0]),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Current Location', masterData.currentLocation),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Permanent Location', masterData.permanentLocation),

            const SizedBox(height: 24), // Increased spacing
            // Academic Information
            _buildSectionTitle(context, 'Academic Information'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Department', masterData.department),
            const Divider(height: 24), // Added divider
            _buildDetailRow('College Location', masterData.collegeLocation),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Active Backlogs', masterData.activeBackLogs),

            const SizedBox(height: 24), // Increased spacing
            _buildSectionTitle(context, '10th Standard'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Board', masterData.std10thBoard),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Percentage', masterData.std10thPercentage),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Passing Year', masterData.std10thPassingYear),

            const SizedBox(height: 24), // Increased spacing
            _buildSectionTitle(context, '12th Standard'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Board', masterData.std12thBoard),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Percentage', masterData.std12thPercentage),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Passing Year', masterData.std12thPassingYear),

            const SizedBox(height: 24), // Increased spacing
            _buildSectionTitle(context, 'Graduation'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Degree', masterData.graduationDegree),
            const Divider(height: 24), // Added divider
            _buildDetailRow(
                'Specialization', masterData.graduationSpecialization),
            const Divider(height: 24), // Added divider
            _buildDetailRow(
                'Year of Passing', masterData.graduationYearOfPassing),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Percentage', masterData.graduationPercentage),

            if (masterData.mastersDegree != 'N/A') ...[
              const SizedBox(height: 24), // Increased spacing
              _buildSectionTitle(context, 'Masters'),
              const SizedBox(height: 8), // Added spacing
              _buildDetailRow('Degree', masterData.mastersDegree),
              const Divider(height: 24), // Added divider
              _buildDetailRow(
                  'Specialization', masterData.mastersSpecialization),
              const Divider(height: 24), // Added divider
              _buildDetailRow(
                  'Year of Passing', masterData.mastersYearOfPassing),
              const Divider(height: 24), // Added divider
              _buildDetailRow('Percentage', masterData.mastersPercentage),
            ],

            const SizedBox(height: 24), // Increased spacing
            _buildSectionTitle(context, 'Professional Information'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow(
                'Prior Experience', masterData.priorExperience ? 'Yes' : 'No'),
            if (masterData.priorExperience) ...[
              const Divider(height: 24), // Added divider
              _buildDetailRow(
                  'Experience in Months', masterData.experienceInMonths),
            ],
            const Divider(height: 24), // Added divider
            _buildDetailRow('LinkedIn Profile', masterData.linkedinProfileLink),
            const Divider(height: 24), // Added divider
            _buildDetailRow(
                'Technical Work Link', masterData.technicalWorkLink),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Resume', masterData.resumeLink),

            const SizedBox(height: 24), // Increased spacing
            _buildSectionTitle(context, 'Parent Information'),
            const SizedBox(height: 8), // Added spacing
            _buildDetailRow('Father\'s Name', masterData.fathersName),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Father\'s Phone', masterData.fathersPhoneNumber),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Father\'s Email', masterData.fathersEmail),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Mother\'s Name', masterData.mothersName),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Mother\'s Phone', masterData.mothersPhoneNumber),
            const Divider(height: 24), // Added divider
            _buildDetailRow('Mother\'s Email', masterData.mothersEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor, // Added color
            ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600, // Changed to semi-bold
                color: Colors.grey, // Added color
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500, // Added weight
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (request.status == RequestStatus.pending) ...[
            ListTile(
              leading: const Icon(Icons.check, color: Colors.green),
              title: const Text('Approve Request'),
              onTap: () {
                Navigator.pop(context);
                _approveRequest(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.red),
              title: const Text('Reject Request'),
              onTap: () {
                Navigator.pop(context);
                _rejectRequest(context);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _approveRequest(BuildContext context) {
    final user = (context.read<AuthCubit>().state as dynamic).user;
    context.read<RequestCubit>().approveRequest(request.id!, user.id);

    // If this is a master data request, also approve the master data
    if (request.type == RequestType.masterData) {
      context.read<MasterDataCubit>().approveMasterData(request.id!);

      // Update the user's masterDataFilled status
      context.read<AuthCubit>().updateUserFormStatus(
            userId: request.id!,
            masterDataFilled: true,
          );
    }
  }

  void _rejectRequest(BuildContext context) {
    final user = (context.read<AuthCubit>().state as dynamic).user;
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for rejection',
                hintText: 'Enter the reason for rejecting this request',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            if (request.type == RequestType.masterData)
              const Text(
                'Note: This will also reject the associated master data.',
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (reasonController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a reason for rejection'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Reject the request
              context.read<RequestCubit>().rejectRequest(
                    request.id!,
                    user.id,
                    reasonController.text,
                  );

              // If this is a master data request, also reject the master data
              if (request.type == RequestType.masterData) {
                context.read<MasterDataCubit>().rejectMasterData(request.id!);
              }

              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return Colors.orange;
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.rejected:
        return Colors.red;
    }
  }
}
